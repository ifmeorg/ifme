#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new(:g){ |g|
  g[:center] = true
  a = g.add_nodes("A", :shape => "sdl_procedure_start", :peripheries => 0 )
  b = g.add_nodes("B", :shape => "sdl_save", :peripheries => 0)
  c = g.add_nodes("n", :shape => "box", :label => "\\G::\\N\\r")
  a << b << c
}.save( :ps => "#{$0}.ps", :extlib => File.join( File.dirname(__FILE__), "sdlshapes", "sdl.ps" ) )
