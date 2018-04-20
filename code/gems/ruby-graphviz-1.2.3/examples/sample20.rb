#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::options( :use => "dot" )

if ARGV[0]
  GraphViz::options( :path => ARGV[0] )
end

GraphViz::new( "g", :rankdir => "LR", :type => "digraph" ) { |g|
  g.node[:fontsize] = "16"
  g.node[:shape] = "record"

  g.node0( :label => "<f0> 0x10ba8| <f1>" )
  g.node1( :label => "<f0> 0xf7fc4380| <f1> | <f2> |-1" )
  g.node2( :label => "<f0> 0xf7fc44b8| | |2" )
  g.node3( :label => "<f0> 3.43322790286038071e-06|44.79998779296875|0" )
  g.node4( :label => "<f0> 0xf7fc4380| <f1> | <f2> |2" )
  g.node5( :label => "<f0> (nil)| | |-1" )
  g.node6( :label => "<f0> 0xf7fc4380| <f1> | <f2> |1" )
  g.node7( :label => "<f0> 0xf7fc4380| <f1> | <f2> |2" )
  g.node8( :label => "<f0> (nil)| | |-1" )
  g.node9( :label => "<f0> (nil)| | |-1" )
  g.node10( :label => "<f0> (nil)| <f1> | <f2> |-1" )
  g.node11( :label => "<f0> (nil)| <f1> | <f2> |-1" )
  g.node12( :label => "<f0> 0xf7fc43e0| | |1" )

  g.add_edges( g.node0(:f0), g.node1(:f0) )
  g.add_edges( g.node0(:f1), g.node2(:f0) )
  g.add_edges( g.node1(:f0), g.node3(:f0) )
  g.add_edges( g.node1(:f1), g.node4(:f0) )
  g.add_edges( g.node1(:f2), g.node5(:f0) )
  g.add_edges( g.node4(:f0), g.node3(:f0) )
  g.add_edges( g.node4(:f1), g.node6(:f0) )
  g.add_edges( g.node4(:f2), g.node10(:f0) )
  g.add_edges( g.node6(:f0), g.node3(:f0) )
  g.add_edges( g.node6(:f1), g.node7(:f0) )
  g.add_edges( g.node6(:f2), g.node9(:f0) )
  g.add_edges( g.node7(:f0), g.node3(:f0) )
  g.add_edges( g.node7(:f1), g.node1(:f0) )
  g.add_edges( g.node7(:f2), g.node8(:f0) )
  g.add_edges( g.node10(:f1), g.node11(:f0) )
  g.add_edges( g.node10(:f2), g.node12(:f0) )
  g.add_edges( g.node11(:f2), g.node1(:f0) )
}.output( :png => "#{$0}.png" )
