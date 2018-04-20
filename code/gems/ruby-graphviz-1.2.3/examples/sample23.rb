#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

r = GraphViz::new( "mainmap" ) { |graph|
  graph[:URL] = "http://www.research.att.com/base.html"
  graph.command( :URL => "http://www.research.att.com/command.html" )
  (graph.command << graph._output( :label => "output" ))[:URL] = "colors.html"
}
puts r.output( :cmapx => String, :png => "#{$0}.png" )
