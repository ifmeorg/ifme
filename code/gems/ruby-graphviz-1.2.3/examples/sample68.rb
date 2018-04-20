$:.unshift("../lib")

require 'graphviz'
require 'graphviz/theory'
g = GraphViz.graph(:G)
g.add_nodes(["A", "B", "C", "D", "E", "F", "G"])
g.add_edges("A", ["B", "C", "E"])
g.add_edges("B", ["D", "F"])
g.add_edges("C", "G")
g.add_edges("F", "E")
g.output(:png => "#{$0}000.png")

t = GraphViz::Theory.new(g)
i = 1
t.dfs("A") { |node|
   name = sprintf("%s%03d.png", $0, i)
   node[:color => :lightblue, :style => :filled]
   g.output(:png => name)
   i = i + 1
}

t.bfs("A") { |node|
   name = sprintf("%s%03d.png", $0, i)
   node[:color => :red, :style => :filled]
   g.output(:png => name)
   i = i + 1
}
