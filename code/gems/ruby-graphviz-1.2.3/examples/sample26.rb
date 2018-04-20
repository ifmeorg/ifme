#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new(:G){ |g|
	(g.hello - g.world) [:style => :bold, :label => " axgle says"]
}.save( :png => "#{$0}.png" )