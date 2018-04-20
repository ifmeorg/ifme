class DoubleException < RuntimeError
end

class GraphViz
  class Types
    class GvDouble < Common
      FLOAT_MASK = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/

      def check(data)
        if data.kind_of?(Numeric) or (data.is_a?(String) and FLOAT_MASK.match(data))
          return data
        end

        return nil if data.is_a?(String) and data.empty?

        raise DoubleException, "Invalid double value for `#{data}`"
      end

      def output
        return @data.to_s.inspect.gsub( "\\\\", "\\" )
      end

      def to_f
        @data.to_f
      end

      alias :to_gv :output
      alias :to_s :output
      alias :to_ruby :to_f
    end
  end
end
