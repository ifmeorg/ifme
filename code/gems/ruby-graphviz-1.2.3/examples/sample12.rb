#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", "path" => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g.node[:shape] = "ellipse"
g.node[:color] = "black"

g[:color] = "black"

g.cluster0( ) do |cluster|
  cluster[:label] = "process #1"
  cluster[:style] = "filled"
  cluster[:color] = "lightgrey"

  cluster.a0 :style => "filled", :color => "white"
  cluster.a1 :style => "filled", :color => "white"
  cluster.a2 :style => "filled", :color => "white"
  cluster.a3 :style => "filled", :color => "white"

  cluster.a0 << cluster.a1
  cluster.a1 << cluster.a2
  cluster.a2 << cluster.a3
end

g.cluster1( :label => "process #2" ) do |cluster|
  cluster.b0 :style => "filled", :color => "blue"
  cluster.b1 :style => "filled", :color => "blue"
  cluster.b2 :style => "filled", :color => "blue"
  cluster.b3 :style => "filled", :color => "blue"

  cluster.b0 << cluster.b1
  cluster.b1 << cluster.b2
  cluster.b2 << cluster.b3
end

g.start :shape => "Mdiamond"
g.endn :shape => "Msquare", :label => "end"

g.start << g.cluster0.a0
g.start << g.cluster1.b0
g.cluster0.a1 << g.cluster1.b3
g.cluster1.b2 << g.cluster0.a3
g.cluster0.a3 << g.cluster0.a0
g.cluster0.a3 << g.endn
g.cluster1.b3 << g.endn

g.output( :png => "#{$0}.png" )