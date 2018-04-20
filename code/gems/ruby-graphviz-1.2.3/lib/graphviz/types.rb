class GraphViz
  class Types
    class Common
      def initialize( data )
        @data = check(data)
      end

      def output
        return @data
      end

      def source
        return @data
      end
    end

    Dir.glob( File.dirname( File.expand_path(__FILE__) )+"/types/*.rb" ).each do |f|
      #autoload File.basename(f).gsub(File.extname(f), "").split( "_" ).map{|n| n.capitalize }.join.to_sym, f
      require f
    end
  end
end
