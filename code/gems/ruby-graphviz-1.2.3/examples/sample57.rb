$:.unshift( "../lib" )

require 'graphviz/graphml'

graphml = File.join( File.dirname( File.expand_path( __FILE__ ) ), "graphml", "port.graphml" )
g = GraphViz::GraphML.new( graphml )
g.graph.output( :png => "#{$0}.png" )
puts g.graph.output( :none => String )
