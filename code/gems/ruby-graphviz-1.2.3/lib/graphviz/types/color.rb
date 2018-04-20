require 'graphviz/utils/colors'

class ColorException < RuntimeError
end

class GraphViz
  class Types
    class Color < Common
      HEX_FOR_COLOR = /[0-9a-fA-F]{2}/
      RGBA = /^#(#{HEX_FOR_COLOR})(#{HEX_FOR_COLOR})(#{HEX_FOR_COLOR})(#{HEX_FOR_COLOR})?$/

      def check(data)
        data = data.to_s if data.is_a?(Symbol)
        return nil if data.empty?

        if data[0].chr == "#"
          m = RGBA.match(data)
          if m.nil?
            raise ColorException, "Wrong color definition RGBA #{data}"
          end
          @to_ruby = GraphViz::Utils::Colors.rgb(m[1], m[2], m[3], m[4])
          return data
        elsif data.include?(",") or data.include?(" ")
          m = data.split(/(?:\s*,\s*|\s+)/).map { |x| x.to_f }
          if m.size != 3
            raise ColorException, "Wrong color definition HSV #{data}"
          end
          @to_ruby = GraphViz::Utils::Colors.hsv(m[0], m[1], m[2])
          return data
        elsif data.is_a?(Array)
          if data.all? { |x| x.is_a?(String) and x =~ /^#{HEX_FOR_COLOR}$/ } and [3,4].include?(data.size)
            @to_ruby = GraphViz::Utils::Colors.rgb(data[0], data[1], data[2], data[3])
            return data
          elsif data.all? { |x| x.kind_of?(Numeric) } and data.size == 3
            @to_ruby = GraphViz::Utils::Colors.hsv(data[0], data[1], data[2])
            return data
          end

          raise ColorException, "Wrong color definition Array #{data}"
        else
          @to_ruby = GraphViz::Utils::Colors.name(data)
          return data
        end
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
