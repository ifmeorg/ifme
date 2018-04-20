class GraphViz
  class Types
    class ColorList < Common
      def check(data)
        data = data.to_s if data.is_a?(Symbol)
        return nil if data.empty?

        @to_ruby = data.split(/\s*:\s*/).map { |c| GraphViz::Types::Color.new(c).to_ruby }
        return data
      end

      def output
        return @data.to_s.inspect.gsub( "\\\\", "\\" )
      end

      alias :to_gv :output
      alias :to_s :output

      def to_ruby
         @data
      end
    end
  end
end
