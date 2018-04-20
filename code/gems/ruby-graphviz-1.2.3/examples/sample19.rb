#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "ER", :type => "graph", :use => "neato" ) { |graph|
  graph.node[:shape] = "box"
  graph.course; graph.institute; graph.student

  graph.node[:shape] = "ellipse"
  graph.name0(:label => "name")
  graph.name1(:label => "name")
  graph.name2(:label => "name")
  graph.code; graph.grade; graph.number

  graph.node[:shape] = "diamond"
  graph.node[:style] = "filled"
  graph.node[:color] = "lightgrey"
  graph.ci( :label => "C-I" )
  graph.sc( :label => "S-C" )
  graph.si( :label => "S-I" )

  graph.name0 << graph.course;
  graph.code << graph.course;

  (graph.course << graph.ci).set { |e|
    e.label = "n"
    e.len = "1.00"
  }

  e = (graph.ci << graph.institute)
  e.label = "1"
  e[:len] = "1.00"

  graph.institute << graph.name1;

  e = (graph.institute << graph.si)
  e[:label] = "1"
  e[:len] = "1.00"

  e = (graph.si << graph.student)
  e[:label] = "n"
  e[:len] = "1.00"

  graph.student << graph.grade
  graph.student << graph.name2
  graph.student << graph.number

  e = (graph.student << graph.sc)
  e[:label] = "m"
  e[:len] = "1.00"

  e = (graph.sc << graph.course)
  e[:label] = "n"
  e[:len] = "1.00"

  graph[:label] = "\\n\\nEntity Relation Diagram\\ndrawn by NEATO";
  graph[:fontsize] = "20";
}.output( :path => '/usr/local/bin/', :png => "#{$0}.png" )