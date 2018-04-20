#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new(:G){ |g|
  g.add_nodes("\"Hello.\"\nHow are you ?", :href => "https://www.example.com/", :tooltip => "\"Hello.\"\nHow are you ?", :shape => "ellipse", :color => "#FF0000")
}.save( :svg => "#{$0}.svg" )
