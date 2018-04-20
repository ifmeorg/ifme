module ActionDispatch
  module Http
    module Parameters
      extend ActiveSupport::Concern

      PARAMETERS_KEY = 'action_dispatch.request.path_parameters'

      DEFAULT_PARSERS = {
        Mime[:json].symbol => -> (raw_post) {
          data = ActiveSupport::JSON.decode(raw_post)
          data.is_a?(Hash) ? data : {:_json => data}
        }
      }

      included do
        class << self
          # Returns the parameter parsers.
          attr_reader :parameter_parsers
        end

        self.parameter_parsers = DEFAULT_PARSERS
      end

      module ClassMethods
        # Configure the parameter parser for a give mime type.
        #
        # It accepts a hash where the key is the symbol of the mime type
        # and the value is a proc.
        #
        #     original_parsers = ActionDispatch::Request.parameter_parsers
        #     xml_parser = -> (raw_post) { Hash.from_xml(raw_post) || {} }
        #     new_parsers = original_parsers.merge(xml: xml_parser)
        #     ActionDispatch::Request.parameter_parsers = new_parsers
        def parameter_parsers=(parsers)
          @parameter_parsers = parsers.transform_keys { |key| key.respond_to?(:symbol) ? key.symbol : key }
        end
      end

      # Returns both GET and POST \parameters in a single hash.
      def parameters
        params = get_header("action_dispatch.request.parameters")
        return params if params

        params = begin
                   request_parameters.merge(query_parameters)
                 rescue EOFError
                   query_parameters.dup
                 end
        params.merge!(path_parameters)
        set_header("action_dispatch.request.parameters", params)
        params
      end
      alias :params :parameters

      def path_parameters=(parameters) #:nodoc:
        delete_header('action_dispatch.request.parameters')

        # If any of the path parameters has an invalid encoding then
        # raise since it's likely to trigger errors further on.
        Request::Utils.check_param_encoding(parameters)

        set_header PARAMETERS_KEY, parameters
      rescue Rack::Utils::ParameterTypeError, Rack::Utils::InvalidParameterError => e
        raise ActionController::BadRequest.new("Invalid path parameters: #{e.message}")
      end

      # Returns a hash with the \parameters used to form the \path of the request.
      # Returned hash keys are strings:
      #
      #   {'action' => 'my_action', 'controller' => 'my_controller'}
      def path_parameters
        get_header(PARAMETERS_KEY) || set_header(PARAMETERS_KEY, {})
      end

      private

      def parse_formatted_parameters(parsers)
        return yield if content_length.zero? || content_mime_type.nil?

        strategy = parsers.fetch(content_mime_type.symbol) { return yield }

        begin
          strategy.call(raw_post)
        rescue # JSON or Ruby code block errors
          my_logger = logger || ActiveSupport::Logger.new($stderr)
          my_logger.debug "Error occurred while parsing request parameters.\nContents:\n\n#{raw_post}"

          raise ParamsParser::ParseError
        end
      end

      def params_parsers
        ActionDispatch::Request.parameter_parsers
      end
    end
  end
end
