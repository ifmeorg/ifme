#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", "path" => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g.node["color"] = "black"

g.edge["color"] = "black"
g.edge["weight"] = "1"
g.edge["style"] = "filled"
g.edge["label"] = ""

g["size"] = "4,4"

g.node["shape"] = "box"
main        = g.add_nodes( "main" )
g.node["shape"] = "ellipse"
parse       = g.add_nodes( "parse" )
execute     = g.add_nodes( "execute" )
init        = g.add_nodes( "init" )
cleanup     = g.add_nodes( "cleanup" )
make_string = g.add_nodes( "make_string", "label" => 'make a\nstring' )
printf      = g.add_nodes( "printf" )
compare     = g.add_nodes( "compare", "shape" => "box", "style" => "filled", "color" => ".7 .3 1.0" )

g.add_edges( main, parse, "weight" => "8" )
g.add_edges( parse, execute )
g.add_edges( main, init, "style" => "dotted" )
g.add_edges( main, cleanup )
g.add_edges( execute, make_string )
g.add_edges( execute, printf )
g.add_edges( init, make_string )
g.add_edges( main, printf, "color" => "red", "style" => "bold", "label" => "100 times" )
g.add_edges( execute, compare, "color" => "red" )

g.output( :png => "#{$0}.png" )
