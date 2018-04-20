#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "G", :type => "graph", :rankdir => "LR" ) { |graph|
  graph.add_edges( [graph.a, graph.b, graph.c], [ graph.d, graph.e, graph.f ] )
}.output( :path => '/usr/local/bin/', :png => "#{$0}.png" )
