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
g.node["color"] = "black"

g["color"] = "black"

c0 = g.add_graph( "cluster0" )
c0["label"] = "process #1"
c0["style"] = "filled"
c0["color"] = "lightgrey"
a0 = c0.add_nodes( "a0", "style" => "filled", "color" => "white" )
a1 = c0.add_nodes( "a1", "style" => "filled", "color" => "white" )
a2 = c0.add_nodes( "a2", "style" => "filled", "color" => "white" )
a3 = c0.add_nodes( "a3", "style" => "filled", "color" => "white" )
c0.add_edges( a0, a1 )
c0.add_edges( a1, a2 )
c0.add_edges( a2, a3 )

c1 = g.add_graph( "cluster1", "label" => "process #2" )
b0 = c1.add_nodes( "b0", "style" => "filled", "color" => "blue" )
b1 = c1.add_nodes( "b1", "style" => "filled", "color" => "blue" )
b2 = c1.add_nodes( "b2", "style" => "filled", "color" => "blue" )
b3 = c1.add_nodes( "b3", "style" => "filled", "color" => "blue" )
c1.add_edges( b0, b1 )
c1.add_edges( b1, b2 )
c1.add_edges( b2, b3 )

start = g.add_nodes( "start", "shape" => "Mdiamond" )
endn  = g.add_nodes( "end",   "shape" => "Msquare" )

g.add_edges( start, a0 )
g.add_edges( start, b0 )
g.add_edges( a1, b3 )
g.add_edges( b2, a3 )
g.add_edges( a3, a0 )
g.add_edges( a3, endn )
g.add_edges( b3, endn )

g.output( :png => "#{$0}.png" )
