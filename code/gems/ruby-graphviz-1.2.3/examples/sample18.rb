#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "G", :rankdir => "LR", :size => "8,5" ) { |graph|
  graph.node[:shape] = "doublecircle"
  graph._LR_0; graph._LR_3; graph._LR_4; graph._LR_8
  graph.node[:shape] = "circle"
  (graph._LR_0 << graph._LR_2)[:label] = "SS(B)"
  (graph._LR_0 << graph._LR_1)[:label] = "SS(S)"
  (graph._LR_1 << graph._LR_3)[:label] = "S($end)"
  (graph._LR_2 << graph._LR_6)[:label] = "SS(b)"
  (graph._LR_2 << graph._LR_5)[:label] = "SS(a)"
  (graph._LR_2 << graph._LR_4)[:label] = "S(A)"
  (graph._LR_5 << graph._LR_7)[:label] = "S(b)"
  (graph._LR_5 << graph._LR_5)[:label] = "S(a)"
  (graph._LR_6 << graph._LR_6)[:label] = "S(b)"
  (graph._LR_6 << graph._LR_5)[:label] = "S(a)"
  (graph._LR_7 << graph._LR_8)[:label] = "S(b)"
  (graph._LR_7 << graph._LR_5)[:label] = "S(a)"
  (graph._LR_8 << graph._LR_6)[:label] = "S(b)"
  (graph._LR_8 << graph._LR_5)[:label] = "S(a)"
}.output( :path => '/usr/local/bin/', :png => "#{$0}.png" )