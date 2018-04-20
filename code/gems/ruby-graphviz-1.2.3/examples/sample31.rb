#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new(:g){ |g|
  a = g.add_nodes( "A:B:C", :shape => :record )
  b = g.add_nodes( "D:E:F", :shape => :ellipse )
  a << b
}.save( :png => "#{$0}.png" )
