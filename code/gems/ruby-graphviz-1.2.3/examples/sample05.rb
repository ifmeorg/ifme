#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "structs", "type" => "graph", "path" => ARGV[0] )
else
  g = GraphViz::new( "structs", "type" => "graph" )
end

main        = g.add_nodes( "main" )
parse       = g.add_nodes( "parse" )
execute     = g.add_nodes( "execute" )
init        = g.add_nodes( "init" )
cleanup     = g.add_nodes( "cleanup" )
make_string = g.add_nodes( "make_string" )
printf      = g.add_nodes( "printf" )
compare     = g.add_nodes( "compare" )

g.add_edges( main, parse )
g.add_edges( parse, execute )
g.add_edges( main, init )
g.add_edges( main, cleanup )
g.add_edges( execute, make_string )
g.add_edges( execute, printf )
g.add_edges( init, make_string )
g.add_edges( main, printf )
g.add_edges( execute, compare )

g.output( :png => "#{$0}.png" )
