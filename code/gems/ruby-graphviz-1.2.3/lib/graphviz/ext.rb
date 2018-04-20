require 'find'

class GraphViz
  class Ext
    def self.find( ext = nil )
      myPath = File.join( File.dirname( File.expand_path( __FILE__ ) ), "..", "ext" )
      found = myPath
      unless ext.nil?
        Find.find(myPath) do |path|
          found = path if File.basename( path ) == ext
        end
      end

      File.expand_path( found )
    end
  end
end