#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::options( :use => "dot" )

if ARGV[0]
  GraphViz::options( :path => ARGV[0] )
end

g = GraphViz::new( "structs" )

g.node["shape"] = "record"

g.add_nodes( "struct1", "shape" => "record", "label" => "<f0> left|<f1> middle|<f2> right" )
g.add_nodes( "struct2", "shape" => "record", "label" => "<f0> one|<f1> two" )
g.add_nodes( "struct3", "shape" => "record", "label" => 'hello\nworld |{ b |{c|<here> d|e}| f}| g | h' )

g.add_edges( { "struct1" => :f1}, {"struct2" => :f0} )
g.add_edges( {"struct1" => :f2}, {"struct3" => :here} )

g.output( :png => "#{$0}.png", :canon => nil )
