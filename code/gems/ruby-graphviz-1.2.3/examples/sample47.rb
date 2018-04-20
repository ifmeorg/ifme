#!/usr/bin/ruby

$:.unshift( "../lib" )
require 'graphviz/xml'

gvxml = GraphViz::XML::new( File.join( File.dirname(__FILE__), "test.xml" ), :text => true, :attrs => true )
gvxml.graph.output( :png => "#{$0}.png", :use => "dot" )
