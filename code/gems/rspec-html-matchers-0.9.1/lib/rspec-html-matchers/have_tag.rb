# frozen_string_literal: true
# encoding: UTF-8

module RSpecHtmlMatchers

  # @api
  # @private
  class HaveTag
    attr_reader :failure_message, :failure_message_when_negated
    attr_reader :parent_scope, :current_scope

    DESCRIPTIONS = {
        :have_at_least_1 => %Q|have at least 1 element matching "%s"|,
        :have_n          => %Q|have %i element(s) matching "%s"|
    }

    MESSAGES = {
        :expected_tag         => %Q|expected following:\n%s\nto #{DESCRIPTIONS[:have_at_least_1]}, found 0.|,
        :unexpected_tag       => %Q|expected following:\n%s\nto NOT have element matching "%s", found %s.|,

        :expected_count       => %Q|expected following:\n%s\nto #{DESCRIPTIONS[:have_n]}, found %s.|,
        :unexpected_count     => %Q|expected following:\n%s\nto NOT have %i element(s) matching "%s", but found.|,

        :expected_btw_count   => %Q|expected following:\n%s\nto have at least %i and at most %i element(s) matching "%s", found %i.|,
        :unexpected_btw_count => %Q|expected following:\n%s\nto NOT have at least %i and at most %i element(s) matching "%s", but found %i.|,

        :expected_at_most     => %Q|expected following:\n%s\nto have at most %i element(s) matching "%s", found %i.|,
        :unexpected_at_most   => %Q|expected following:\n%s\nto NOT have at most %i element(s) matching "%s", but found %i.|,

        :expected_at_least    => %Q|expected following:\n%s\nto have at least %i element(s) matching "%s", found %i.|,
        :unexpected_at_least  => %Q|expected following:\n%s\nto NOT have at least %i element(s) matching "%s", but found %i.|,

        :expected_regexp      => %Q|%s regexp expected within "%s" in following template:\n%s|,
        :unexpected_regexp    => %Q|%s regexp unexpected within "%s" in following template:\n%s\nbut was found.|,

        :expected_text        => %Q|"%s" expected within "%s" in following template:\n%s|,
        :unexpected_text      => %Q|"%s" unexpected within "%s" in following template:\n%s\nbut was found.|,

        :wrong_count_error    => %Q|:count with :minimum or :maximum has no sence!|,
        :min_max_error        => %Q|:minimum should be less than :maximum!|,
        :bad_range_error      => %Q|Your :count range(%s) has no sence!|,
    }


    def initialize tag, options={}, &block
      @tag, @options, @block = tag.to_s, options, block

      if with_attrs = @options.delete(:with)
        if classes = with_attrs.delete(:class)
          @tag += '.' + classes_to_selector(classes)
        end
        selector = with_attrs.inject('') do |html_attrs_string, (k, v)|
          html_attrs_string += "[#{k}='#{v}']"
          html_attrs_string
        end
        @tag += selector
      end

      if without_attrs = @options.delete(:without)
        if classes = without_attrs.delete(:class)
          @tag += ":not(.#{classes_to_selector(classes)})"
        end
      end

      validate_options!
      set_options
    end

    def matches? document, &block
      @block = block if block

      document = document.html if defined?(Capybara::Session) && document.is_a?(Capybara::Session)

      case document
        when String
          @parent_scope = Nokogiri::HTML(document)
          @document     = document
        else
          @parent_scope  = document.current_scope
          @document      = @parent_scope.to_html
      end
      @current_scope = begin
        @parent_scope.css(@tag)
          # on jruby this produce exception if css was not found:
          # undefined method `decorate' for nil:NilClass
      rescue NoMethodError
        Nokogiri::XML::NodeSet.new(Nokogiri::XML::Document.new)
      end
      if tag_presents? and text_right? and count_right?
        @block.call(self) if @block
        true
      else
        false
      end
    end

    def document
      @document
    end

    def description
      # TODO should it be more complicated?
      if @options.has_key?(:count)
        DESCRIPTIONS[:have_n] % [@options[:count],@tag]
      else
        DESCRIPTIONS[:have_at_least_1] % @tag
      end
    end

    private

    def classes_to_selector(classes)
      case classes
        when Array
          classes.join('.')
        when String
          classes.gsub(/\s+/, '.')
      end
    end

    def tag_presents?
      if @current_scope.first
        @count = @current_scope.count
        @failure_message_when_negated = MESSAGES[:unexpected_tag] % [@document, @tag, @count]
        true
      else
        @failure_message          = MESSAGES[:expected_tag] % [@document, @tag]
        false
      end
    end

    def count_right?
      case @options[:count]
        when Integer
          ((@failure_message_when_negated=MESSAGES[:unexpected_count] % [@document,@count,@tag]) && @count == @options[:count]) || (@failure_message=MESSAGES[:expected_count] % [@document,@options[:count],@tag,@count]; false)
        when Range
          ((@failure_message_when_negated=MESSAGES[:unexpected_btw_count] % [@document,@options[:count].min,@options[:count].max,@tag,@count]) && @options[:count].member?(@count)) || (@failure_message=MESSAGES[:expected_btw_count] % [@document,@options[:count].min,@options[:count].max,@tag,@count]; false)
        when nil
          if @options[:maximum]
            ((@failure_message_when_negated=MESSAGES[:unexpected_at_most] % [@document,@options[:maximum],@tag,@count]) && @count <= @options[:maximum]) || (@failure_message=MESSAGES[:expected_at_most] % [@document,@options[:maximum],@tag,@count]; false)
          elsif @options[:minimum]
            ((@failure_message_when_negated=MESSAGES[:unexpected_at_least] % [@document,@options[:minimum],@tag,@count]) && @count >= @options[:minimum]) || (@failure_message=MESSAGES[:expected_at_least] % [@document,@options[:minimum],@tag,@count]; false)
          else
            true
          end
      end
    end

    def text_right?
      return true unless @options[:text]

      case text=@options[:text]
        when Regexp
          new_scope = @current_scope.css(':regexp()',NokogiriRegexpHelper.new(text))
          unless new_scope.empty?
            @count = new_scope.count
            @failure_message_when_negated = MESSAGES[:unexpected_regexp] % [text.inspect,@tag,@document]
            true
          else
            @failure_message          = MESSAGES[:expected_regexp] % [text.inspect,@tag,@document]
            false
          end
        else
          new_scope = @current_scope.css(':content()', NokogiriTextHelper.new(text, @options[:squeeze_text]))
          unless new_scope.empty?
            @count = new_scope.count
            @failure_message_when_negated = MESSAGES[:unexpected_text] % [text,@tag,@document]
            true
          else
            @failure_message          = MESSAGES[:expected_text] % [text,@tag,@document]
            false
          end
      end
    end

    protected

    def validate_options!
      validate_count_presence!
      validate_count_when_set_min_max!
      validate_count_when_set_range!
    end

    def validate_count_presence!
      raise 'wrong :count specified' unless [Range, NilClass].include?(@options[:count].class) or @options[:count].is_a?(Integer)

      [:min, :minimum, :max, :maximum].each do |key|
        raise MESSAGES[:wrong_count_error] if @options.has_key?(key) and @options.has_key?(:count)
      end
    end

    def validate_count_when_set_min_max!
      begin
        raise MESSAGES[:min_max_error] if @options[:minimum] > @options[:maximum]
      rescue NoMethodError # nil > 4
      rescue ArgumentError # 2 < nil
      end
    end

    def validate_count_when_set_range!
      begin
        begin
          raise MESSAGES[:bad_range_error] % [@options[:count].to_s] if count_is_range_but_no_min?
        rescue ArgumentError, "comparison of String with" # if @options[:count] == 'a'..'z'
          raise MESSAGES[:bad_range_error] % [@options[:count].to_s]
        end
      rescue TypeError # fix for 1.8.7 for 'rescue ArgumentError, "comparison of String with"' stroke
        raise MESSAGES[:bad_range_error] % [@options[:count].to_s]
      end
    end

    def count_is_range_but_no_min?
      @options[:count] && @options[:count].is_a?(Range) &&
          (@options[:count].min.nil? or @options[:count].min < 0)
    end

    def set_options
      @options[:minimum] ||= @options.delete(:min)
      @options[:maximum] ||= @options.delete(:max)

      @options[:text] = @options[:text].to_s if @options.has_key?(:text) && !@options[:text].is_a?(Regexp)

      if @options.has_key?(:seen) && !@options[:seen].is_a?(Regexp)
        @options[:text] = @options[:seen].to_s
        @options[:squeeze_text] = true
      end
    end

  end

end
