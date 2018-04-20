#!/usr/bin/ruby

$:.unshift( "../../lib" );
require "graphviz"

GraphViz.new(:g){ |g|
  g[:center] = true
  a = g.add_nodes("A", :shape => "rgv_box", :peripheries => 0)
  b = g.add_nodes("Bonjour le monde\nComment va tu ?", :shape => "rgv_cloud", :peripheries => 0)
  c = g.add_nodes("C", :shape => "rgv_flower", :peripheries => 0)
  a << b << c
}.save( :ps => "#{$0}.ps", :extlib => "rgv.ps" )
