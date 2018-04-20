#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new(:G){ |g|
  g[:ratio => "auto", :label => "I love the world!"]

	g.hello( :label => "Hello", :color => "blue" ) # You can do this
	g.none[ :label => "World", :color => "green" ] # or that
	(g.hello - g.none)[:style => :bold, :label => " I say"]
}.save( :png => "#{$0}.png" )
