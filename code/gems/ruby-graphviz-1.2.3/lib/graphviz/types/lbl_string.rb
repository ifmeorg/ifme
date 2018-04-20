require "rexml/document"

class GraphViz
  class Types
    class LblString < Common
      def check(data)
        return data
      end

      def output
        html = /^<(.*)>$/m.match(@data.to_s)
        if html != nil
          xml = "<gv>" + html[1].to_s + "</gv>"
          begin
            doc = REXML::Document.new(xml)
            unless doc.root.text == html[1].to_s
              "<#{html[1]}>"
            else
              @data.to_s.inspect.gsub( "\\\\", "\\" )
            end
          rescue REXML::ParseException => _
            @data.to_s.inspect.gsub( "\\\\", "\\" )
          end
        else
          @data.to_s.inspect.gsub( "\\\\", "\\" )
        end
      end

      alias :to_gv :output
      alias :to_s :output
      alias :to_ruby :output
    end
  end
end
