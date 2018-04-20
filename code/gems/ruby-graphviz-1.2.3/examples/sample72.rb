#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", :path => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g.node[:color] = "#FF0000:#FFFFFF"
g.add_edges("noDe", "graph")
g.add_edges("node", "graph")
g.add_edges("node", "Graph")
g.add_edges("graph", "subgraph")
g.add_edges("edge", "node")
g.add_edges("subgraph", "digraph")
g.add_edges("subgraph", "strict")

g.output( :png => "#{$0}.png" )
