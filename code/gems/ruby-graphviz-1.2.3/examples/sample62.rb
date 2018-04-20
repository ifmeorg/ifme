#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

hello_world = GraphViz::new( "" )

hello = hello_world.add_nodes("Hello")
world = hello_world.add_nodes("World")
hello_world.add_edges(hello, world)

# final_graph = GraphViz.parse_string( hello_world.output( :dot => String ) )
# final_graph.each_node do |_, node|
#    puts "Node #{node.id} : position = #{node[:pos]}"
# end

hello_world = hello_world.complete
hello_world.each_node do |_, node|
   puts "Node #{node.id} : position = " ; p node[:pos].point
end

puts "---------"

puts hello_world.output( :canon => String )
