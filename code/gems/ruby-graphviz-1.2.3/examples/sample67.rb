$:.unshift("../lib")

require 'graphviz'
graph = GraphViz.graph(:G)
graph.add_nodes(["A", "B", "C", "D", "E", "F", "G"])
graph.add_edges("A", ["B", "C", "E"])
graph.add_edges("B", ["D", "F"])
graph.add_edges("C", "G")
graph.add_edges("F", "E")
graph.output(:png => "#{$0}.png")
