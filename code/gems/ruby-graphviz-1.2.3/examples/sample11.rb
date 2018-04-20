#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

graph = nil
if ARGV[0]
  graph = GraphViz::new( "G", "path" => ARGV[0] )
else
  graph = GraphViz::new( "G" )
end

graph["compound"] = "true"
graph.edge["lhead"] = ""
graph.edge["ltail"] = ""

c0 = graph.add_graph( "cluster0" )
a = c0.add_nodes( "a" )
b = c0.add_nodes( "b" )
c = c0.add_nodes( "c" )
d = c0.add_nodes( "d" )
c0.add_edges( a, b )
c0.add_edges( a, c )
c0.add_edges( b, d )
c0.add_edges( c, d )

c1 = graph.add_graph( "cluster1" )
e = c1.add_nodes( "e" )
f = c1.add_nodes( "f" )
g = c1.add_nodes( "g" )
c1.add_edges( e, g )
c1.add_edges( e, f )

h = graph.add_nodes( "h" )

graph.add_edges( b, f, "lhead" => "cluster1" )
graph.add_edges( d, e )
graph.add_edges( c, g, "ltail" => "cluster0", "lhead" => "cluster1" )
graph.add_edges( c, e, "ltail" => "cluster0" )
graph.add_edges( d, h )

graph.output( :png => "#{$0}.png" )
