#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

puts GraphViz.new(:G){ |g|
	(g.hello - g.none) [:style => :bold, :label => " dburt says"]
}.save( :none => String )
