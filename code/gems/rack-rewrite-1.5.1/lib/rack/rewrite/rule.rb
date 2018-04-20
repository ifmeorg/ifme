require 'rack/mime'

module Rack
  class Rewrite
    class RuleSet
      attr_reader :rules
      def initialize(options = {})#:nodoc:
        @rules = []
      end

      protected
        # We're explicitly defining private functions for our DSL rather than
        # using method_missing

        # Creates a rewrite rule that will simply rewrite the REQUEST_URI,
        # PATH_INFO, and QUERY_STRING headers of the Rack environment.  The
        # user's browser will continue to show the initially requested URL.
        #
        #  rewrite '/wiki/John_Trupiano', '/john'
        #  rewrite %r{/wiki/(\w+)_\w+}, '/$1'
        #  rewrite %r{(.*)}, '/maintenance.html', :if => lambda { File.exists?('maintenance.html') }
        def rewrite(*args)
          add_rule :rewrite, *args
        end

        # Creates a redirect rule that will send a 301 when matching.
        #
        #  r301 '/wiki/John_Trupiano', '/john'
        #  r301 '/contact-us.php', '/contact-us'
        #
        # You can use +moved_permanently+ or just +p+ instead of +r301+.
        def r301(*args)
          add_rule :r301, *args
        end

        alias :moved_permanently :r301
        alias :p :r301

        # Creates a redirect rule that will send a 302 when matching.
        #
        #  r302 '/wiki/John_Trupiano', '/john'
        #  r302 '/wiki/(.*)', 'http://www.google.com/?q=$1'
        #
        # You can use +found+ instead of +r302+.
        def r302(*args)
          add_rule :r302, *args
        end

        alias :found :r302

        # Creates a redirect rule that will send a 303 when matching.
        #
        #  r303 '/wiki/John_Trupiano', '/john'
        #  r303 '/wiki/(.*)', 'http://www.google.com/?q=$1'
        #
        # You can use +see_other+ instead of +r303+.
        def r303(*args)
          add_rule :r303, *args
        end

        alias :see_other :r303

        # Creates a redirect rule that will send a 307 when matching.
        #
        #  r307 '/wiki/John_Trupiano', '/john'
        #  r307 '/wiki/(.*)', 'http://www.google.com/?q=$1'
        #
        # You can use +temporary_redirect+ or +t+ instead of +r307+.
        def r307(*args)
          add_rule :r307, *args
        end

        alias :temporary_redirect :r307
        alias :t :r307

        # Creates a rule that will render a file if matched.
        #
        #  send_file /*/, 'public/system/maintenance.html',
        #    :if => Proc.new { File.exists?('public/system/maintenance.html') }
        def send_file(*args)
          add_rule :send_file, *args
        end

        # Creates a rule that will render a file using x-send-file
        # if matched.
        #
        #  x_send_file /*/, 'public/system/maintenance.html',
        #    :if => Proc.new { File.exists?('public/system/maintenance.html') }
        def x_send_file(*args)
          add_rule :x_send_file, *args
        end

        # Creates a rule taht will render the raw data if matched
        #  send_data /*/, 'public/system/maintenance.html',
        #    :if => Proc.new { File.exists?('public/system/maintenance.html') }
        def send_data(*args)
          add_rule :send_data, *args
        end

      private
        def add_rule(method, from, to, options = {}) #:nodoc:
          @rules << Rule.new(method.to_sym, from, to, options)
        end

    end

    # TODO: Break rules into subclasses
    class Rule #:nodoc:
      attr_reader :rule_type, :to, :options
      def initialize(rule_type, from, to, options={}) #:nodoc:
        @rule_type, @from, @to, @options = rule_type, from, to, normalize_options(options)
      end

      def matches?(rack_env) #:nodoc:
        return false if options[:if].respond_to?(:call) && !options[:if].call(rack_env)
        path = build_path_from_env(rack_env)

        self.match_options?(rack_env) && string_matches?(path, self.from)
      end

      def from
        return @static_from if @static_from
        @from.respond_to?(:call) ? @from.call : @static_from = @from
      end

      # Either (a) return a Rack response (short-circuiting the Rack stack), or
      # (b) alter env as necessary and return true
      def apply!(env) #:nodoc:
        interpreted_to = self.interpret_to(env)
        additional_headers = {}
        if @options[:headers]
          if @options[:headers].respond_to?(:call)
            additional_headers = @options[:headers].call || {}
          else
            additional_headers = @options[:headers] || {}
          end
        end
        status = @options[:status] || 200
        case self.rule_type
        when :r301
          [301, {'Location' => interpreted_to, 'Content-Type' => Rack::Mime.mime_type(::File.extname(interpreted_to))}.merge!(additional_headers), [redirect_message(interpreted_to)]]
        when :r302
          [302, {'Location' => interpreted_to, 'Content-Type' => Rack::Mime.mime_type(::File.extname(interpreted_to))}.merge!(additional_headers), [redirect_message(interpreted_to)]]
        when :r303
          [303, {'Location' => interpreted_to, 'Content-Type' => Rack::Mime.mime_type(::File.extname(interpreted_to))}.merge!(additional_headers), [redirect_message(interpreted_to)]]
        when :r307
          [307, {'Location' => interpreted_to, 'Content-Type' => Rack::Mime.mime_type(::File.extname(interpreted_to))}.merge!(additional_headers), [redirect_message(interpreted_to)]]
        when :rewrite
          # return [200, {}, {:content => env.inspect}]
          env['REQUEST_URI'] = interpreted_to
          if q_index = interpreted_to.index('?')
            env['PATH_INFO'] = interpreted_to[0..q_index-1]
            env['QUERY_STRING'] = interpreted_to[q_index+1..interpreted_to.size-1]
          else
            env['PATH_INFO'] = interpreted_to
            env['QUERY_STRING'] = ''
          end
          true
        when :send_file
          [status, {
            'Content-Length' => ::File.size(interpreted_to).to_s,
            'Content-Type'   => Rack::Mime.mime_type(::File.extname(interpreted_to))
            }.merge!(additional_headers), [::File.read(interpreted_to)]]
        when :x_send_file
          [status, {
            'X-Sendfile'     => interpreted_to,
            'Content-Length' => ::File.size(interpreted_to).to_s,
            'Content-Type'   => Rack::Mime.mime_type(::File.extname(interpreted_to))
            }.merge!(additional_headers), []]
        when :send_data
          [status, {
            'Content-Length' => interpreted_to.bytesize,
            'Content-Type' => 'text/html',
          }.merge!(additional_headers), [interpreted_to]]
        else
          raise Exception.new("Unsupported rule: #{self.rule_type}")
        end
      end

      protected
        def interpret_to(env) #:nodoc:
          path = build_path_from_env(env)
          return interpret_to_proc(path, env) if self.to.is_a?(Proc)
          return computed_to(path) if compute_to?(path)
          self.to
        end

        def is_a_regexp?(obj)
          obj.is_a?(Regexp) || (Object.const_defined?(:Oniguruma) && obj.is_a?(Oniguruma::ORegexp))
        end

        def match_options?(env, path = build_path_from_env(env))
          matches = []
          request = Rack::Request.new(env)

          # negative matches
          matches << !string_matches?(path, options[:not]) if options[:not]

          # possitive matches
          matches << string_matches?(env['REQUEST_METHOD'], options[:method]) if options[:method]
          matches << string_matches?(request.host, options[:host]) if options[:host]
          matches << string_matches?(request.scheme, options[:scheme]) if options[:scheme]

          matches.all?
        end

      private
        def normalize_options(arg)
          options = arg.respond_to?(:call) ? {:if => arg} : arg
          options.symbolize_keys! if options.respond_to? :symbolize_keys!
          options.freeze
        end

        def interpret_to_proc(path, env)
          return self.to.call(match(path), env) if self.from.is_a?(Regexp)
          self.to.call(self.from, env)
        end

        def compute_to?(path)
          self.is_a_regexp?(from) && match(path)
        end

        def match(path)
          self.from.match(path)
        end

        def string_matches?(string, matcher)
          if self.is_a_regexp?(matcher)
            string =~ matcher
          elsif matcher.is_a?(String)
            string == matcher
          elsif matcher.is_a?(Symbol)
            string.downcase == matcher.to_s.downcase
          else
            false
          end
        end

        def computed_to(path)
          # is there a better way to do this?
          computed_to = self.to.dup
          computed_to.gsub!("$&",match(path).to_s)
          (match(path).size - 1).downto(1) do |num|
            computed_to.gsub!("$#{num}", match(path)[num].to_s)
          end
          return computed_to
        end

        # Construct the URL (without domain) from PATH_INFO and QUERY_STRING
        def build_path_from_env(env)
          path = env['PATH_INFO'] || ''
          path += "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].nil? || env['QUERY_STRING'].empty?
          path
        end

        def redirect_message(location)
          %Q(Redirecting to <a href="#{location}">#{location}</a>)
        end
    end
  end
end
