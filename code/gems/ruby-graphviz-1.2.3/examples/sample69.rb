#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = GraphViz::new( "G", :type => "graph" )
g[:compound] = true
g[:rankdir] = "LR"

c0 = g.add_graph( "cluster0", "label" => "cluster #1"  )
a0 = c0.add_nodes( "a0" )

c1 = g.add_graph( "cluster1", "label" => "cluster #2" )
b0 = c1.add_nodes( "b0" )

e1 = g.add_edges(a0,b0)
e1[:lhead] = c1.id
e1[:ltail] = c0.id

e2 = g.add_edges(a0,b0)
e2[:lhead] = c1.id

g.output( :png => "#{$0}.png" )
