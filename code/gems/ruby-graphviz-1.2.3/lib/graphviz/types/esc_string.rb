class GraphViz
  class Types
    class EscString < Common
      def check(data)
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
