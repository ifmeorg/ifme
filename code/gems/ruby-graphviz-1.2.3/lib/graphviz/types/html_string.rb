# TODO: Remove
class GraphViz
  class Types
    class HtmlString < Common
      def check(data)
        return data
      end

      def output
        return "<"+@data+">"
      end

      alias :to_gv :output
      alias :to_s :output
      alias :to_ruby :output
    end
  end
end
