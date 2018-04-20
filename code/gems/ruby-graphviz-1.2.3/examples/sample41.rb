#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

GraphViz::new( "G" ) { |g|
  g.hello(:style => :filled, :fillcolor => :lightblue) << g.world(:style => :filled, :fillcolor => :lightgrey)
}.output( :svg => "#{$0}.svg", :nothugly => true )
