# coding: utf-8
$:.unshift( "../lib" )
require "graphviz"

g = GraphViz::new( :G ) { |_g|
  _g.a[:label => "ε"]
  _g.add_nodes( "b", :label => "ε" )
  _g.c[:label => 'ε']
  _g.add_nodes( "d", :label => 'ε' )
}

puts g.output( :none => String, :png => "#{$0}.png", :path => "/usr/local/bin" )
