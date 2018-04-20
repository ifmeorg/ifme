#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", "path" => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g.node["shape"] = "ellipse"
g.node["sides"] = "4"
g.node["peripheries"] = ""
g.node["color"] = "black"
g.node["style"] = ""
g.node["skew"] = "0.0"
g.node["distortion"] = "0.0"

a = g.add_nodes( "a", "shape" => "polygon", "sides" => "5", "peripheries" => "3", "color" => "lightblue", "style" => "filled"  )
b = g.add_nodes( "b" )
c = g.add_nodes( "c", "shape" => "polygon", "sides" => "4", "skew" => ".4", "label" => "hello world" )
d = g.add_nodes( "d", "shape" => "invtriangle" )
e = g.add_nodes( "e", "shape" => "polygon", "sides" => "4", "distortion" => ".7" )

g.add_edges( a, b )
g.add_edges( b, c )
g.add_edges( b, d )

g.output( :png => "#{$0}.png" )
