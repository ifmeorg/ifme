require 'resque_mailer/version'
require 'resque_mailer/serializers/pass_thru_serializer'
require 'resque_mailer/serializers/active_record_serializer'

module Resque
  module Mailer
    class << self
      attr_accessor :default_queue_name, :default_queue_target, :current_env, :logger, :error_handler
      attr_accessor :argument_serializer
      attr_reader :excluded_environments

      def excluded_environments=(envs)
        @excluded_environments = [*envs].map { |e| e.to_sym }
      end

      def included(base)
        base.extend(ClassMethods)
      end
    end

    self.logger ||= (defined?(Rails) ? Rails.logger : nil)
    self.default_queue_target = ::Resque
    self.default_queue_name = "mailer"
    self.excluded_environments = [:test]
    self.argument_serializer = ::Resque::Mailer::Serializers::PassThruSerializer

    module ClassMethods

      def current_env
        if defined?(Rails)
          ::Resque::Mailer.current_env || ::Rails.env
        else
          ::Resque::Mailer.current_env
        end
      end

      def method_missing(method_name, *args)
        if action_methods.include?(method_name.to_s)
          MessageDecoy.new(self, method_name, *args)
        else
          super
        end
      end

      def perform(action, serialized_args)
        begin
          args = ::Resque::Mailer.argument_serializer.deserialize(serialized_args)
          message = self.send(:new, action, *args).message
          if message.respond_to?(:deliver_now)
            message.deliver_now
          else
            message.deliver
          end
        rescue Exception => ex
          if Mailer.error_handler
            Mailer.error_handler.call(self, message, ex, action, args)
          else
            if logger
              logger.error "Unable to deliver email [#{action}]: #{ex}"
              logger.error ex.backtrace.join("\n\t")
            end

            raise ex
          end
        end
      end

      def queue
        @queue || ::Resque::Mailer.default_queue_name
      end

      def queue=(name)
        @queue = name
      end

      def resque
        ::Resque::Mailer.default_queue_target
      end

      def excluded_environment?(name)
        ::Resque::Mailer.excluded_environments && ::Resque::Mailer.excluded_environments.include?(name.try(:to_sym))
      end

      def deliver?
        true
      end
    end

    class MessageDecoy
      delegate :to_s, :to => :actual_message

      def initialize(mailer_class, method_name, *args)
        @mailer_class = mailer_class
        @method_name = method_name
        *@args = *args
        @serialized_args = ::Resque::Mailer.argument_serializer.serialize(*args)
        actual_message if environment_excluded?
      end

      def resque
        ::Resque::Mailer.default_queue_target
      end

      def current_env
        if defined?(Rails)
          ::Resque::Mailer.current_env || ::Rails.env
        else
          ::Resque::Mailer.current_env
        end
      end

      def environment_excluded?
        !ActionMailer::Base.perform_deliveries || excluded_environment?(current_env)
      end

      def excluded_environment?(name)
        ::Resque::Mailer.excluded_environments && ::Resque::Mailer.excluded_environments.include?(name.to_sym)
      end

      def actual_message
        @actual_message ||= @mailer_class.send(:new, @method_name, *@args).message
      end

      def deliver
        return deliver! if environment_excluded?

        if @mailer_class.deliver?
          begin
            resque.enqueue(@mailer_class, @method_name, @serialized_args)
          rescue Errno::ECONNREFUSED, Redis::CannotConnectError
            logger.error "Unable to connect to Redis; falling back to synchronous mail delivery" if logger
            deliver!
          end
        end
      end

      def deliver_at(time)
        return deliver! if environment_excluded?

        unless resque.respond_to? :enqueue_at
          raise "You need to install resque-scheduler to use deliver_at"
        end

        if @mailer_class.deliver?
          resque.enqueue_at(time, @mailer_class, @method_name, *@args)
        end
      end

      def deliver_in(time)
        return deliver! if environment_excluded?

        unless resque.respond_to? :enqueue_in
          raise "You need to install resque-scheduler to use deliver_in"
        end

        if @mailer_class.deliver?
          resque.enqueue_in(time, @mailer_class, @method_name, *@args)
        end
      end

      def unschedule_delivery
        unless resque.respond_to? :remove_delayed
          raise "You need to install resque-scheduler to use unschedule_delivery"
        end

        resque.remove_delayed(@mailer_class, @method_name, *@args)
      end

      def deliver!
        if actual_message.respond_to?(:deliver_now)
          actual_message.deliver_now
        else
          actual_message.deliver
        end
      end

      def method_missing(method_name, *args)
        actual_message.send(method_name, *args)
      end

      def respond_to?(method_name, *args)
        super || actual_message.respond_to?(method_name, *args)
      end

      def logger
        @mailer_class.logger
      end
    end
  end
end
