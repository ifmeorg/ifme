#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new(:G){ |g|
  g.edge[:arrowsize => 0.5]
  g.graph[:bb => "0,0,638,256"]
  g.person[:shape => :record];
  g.driver[:shape => :ellipse];
  g.owner[:shape => :ellipse];
  g.passenger[:shape => :ellipse];
  g.vehicle[:shape => :record];
}.save( :png => "#{$0}.png" )
