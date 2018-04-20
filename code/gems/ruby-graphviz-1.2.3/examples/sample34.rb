#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

GraphViz.new(:G) { |g|
  g[:color] = "black"

  g.one :label => "1"

  # This is an anonymous graph
  c = g.add_graph( :rank => "same" ) { |c|
    c.two :label => "2"
    c.three :label => "3"
    c.two << c.three
  }

  # And this is not!
  k = g.add_graph( "Hello" ) { |k|
    k.four :label => "4"
    k.five :label => "5"
    k.four << k.five
  }

  g.one << c.two
  g.one << c.three
  c.two << k.four
  c.three << k.five
}.output( :canon => String )
