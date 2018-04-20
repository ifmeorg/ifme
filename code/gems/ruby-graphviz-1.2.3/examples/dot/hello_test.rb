#!/usr/bin/ruby

$:.unshift( "../../lib" );
require "graphviz"

g = GraphViz.parse( "hello.dot", :path => "/usr/local/bin" ) { |g|
  g.graph[:color] = "blue"
  g.node[:color] = "red"
  g.edge[:color] = "yellow"
  g.get_node("Hello") { |n|
    n.label = "Bonjour"
  }
  g.get_node("World") { |n|
    n.label = "Le Monde"
  }
}

g.graph.each do |k, v|
  puts "graph : #{k} => #{v}"
end

g.node.each do |k, v|
  puts "node : #{k} => #{v}"
end

g.edge.each do |k, v|
  puts "edge : #{k} => #{v}"
end

puts "-----------"

puts g.output(:none => String)

