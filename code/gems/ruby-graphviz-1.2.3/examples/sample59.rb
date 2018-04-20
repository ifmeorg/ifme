$:.unshift( "../lib" )
require "graphviz"

graph = {
  "a" => {
    "b" => "d",
    "c" => ["e", "f", "a"]
  },
  "g" => "e",
}

g = GraphViz::new( "G" )
g.add(graph)
g.output( :png => "#{$0}.png" )