class RectException < RuntimeError
end

class GraphViz
  class Types
    class Rect < Common
      FLOAT_MASK = /[-+]?(?:[0-9]*\.[0-9]+|[0-9]+)/
      RECT_FINAL_MASK = /#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}\s*,\s*#{FLOAT_MASK}/

      def check(data)
        if data.is_a?(String) and RECT_FINAL_MASK.match(data)
           @to_ruby = data.split(",").map{ |e| e.to_f }
           return data
        end
        if data.is_a?(Array)
           return check(data.join(","))
        end
        return nil if data.is_a?(String) and data.empty?

        raise RectException, "Invalid rect value"
      end

      def output
        return @data.to_s.inspect.gsub( "\\\\", "\\" )
      end

      alias :to_gv :output
      alias :to_s :output

      def to_ruby
         @to_ruby
      end
    end
  end
end
