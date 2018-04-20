#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "mainmap" ) { |graph|
  graph[:URL] = "http://www.research.att.com/base.html"
  graph.command( :URL => "http://www.research.att.com/command.html" )
  (graph.command << graph._output( :label => "output" ))[:URL] = "colors.html"
}.output( :canon => nil, :cmapx => "#{$0}.html", :png => "#{$0}.png" )
