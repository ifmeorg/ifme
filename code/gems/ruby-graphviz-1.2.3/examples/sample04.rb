#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "structs", "path" => ARGV[0] )
else
  g = GraphViz::new( "structs" )
end

g.node["shape"] = "record"

struct1 = g.add_nodes( "struct1", "shape" => "record", "label" => "<f0> left|<f1> mid\ dle|<f2> right" )
struct2 = g.add_nodes( "struct2", "shape" => "record", "label" => "<f0> one|<f1> two" )
struct3 = g.add_nodes( "struct3", "shape" => "record", "label" => 'hello\nworld |{ b |{c|<here> d|e}| f}| g | h' )

g.add_edges( struct1, struct2 )
g.add_edges( struct1, struct3 )

g.output( :png => "#{$0}.png" )
