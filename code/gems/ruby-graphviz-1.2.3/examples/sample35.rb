#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

GraphViz.digraph( :G ) { |g|
  g[:truecolor => true, :bgcolor => "transparent", :rankdir => "LR"]
  g.node[:label => "\N"]

  c1 = g.subgraph { |c|
    c[:rank => "same"]
    c.mygraph[
      :label => '# mygraph.dot\ldigraph G {\l  Hello -> World\l}\l',
      :shape => "note",
      :fontname => "Courier",
      :fontsize => 10
    ]
    c.image[ :label => "", :shape => "note", :image => "./hello.png"]
  }

  c2 = g.subgraph { |c|
    c[:rank => "same"]
    c.mysite[:label => "\nexample.com\n ", :shape => "component", :fontname => "Arial"]
    c.dotgraph[:label => "\ndotgraph.net\n ", :shape => "component", :fontname => "Arial"]
  }

  g.cluster_0 { |c|
    c[
      :label => "my_page.html",
      :fontname => "Courier",
      :fontsize => 10,
      :color => "black"
    ]
    c.zeimage[:label => "", :shape => "note", :image => "./hello.png"]
  }

  (c1.mygraph << c2.mysite)[:color => "blue"]
  (c2.dotgraph << c1.image)[:color => "red"]
  (c2.dotgraph << c2.mysite)[:color => "red"]
  (c2.mysite << c2.dotgraph)[:color => "blue"]
  (c1.image << c2.dotgraph)[:color => "red"]
  (c2.mysite << g.cluster_0.zeimage)[:color => "red"]
}.output( :png => "#{$0}.png", :none => "#{$0}.gv" )
