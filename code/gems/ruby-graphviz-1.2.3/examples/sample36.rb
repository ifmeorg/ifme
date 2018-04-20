#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

GraphViz.graph( :G ) { |g|
  last_line = []
  node_number = 0

  100.times do |j|
    # New_Line
    new_line = []
    c = g.subgraph( :rank => "same" )

    100.times do |i|
      current_node = c.add_nodes( "N#{node_number}", :shape => "point", :label => "" )
      last_node = new_line[-1]
      unless last_node.nil?
        c.add_edges( last_node, current_node )
      end
      new_line << current_node
      top_first_node = last_line.shift
      unless top_first_node.nil?
        g.add_edges( top_first_node, current_node )
        top_second_node = last_line.shift
        unless top_second_node.nil?
          g.add_edges( top_second_node, current_node )
          last_line.unshift( top_second_node )
        end
      end
      node_number = node_number + 1
    end
    last_line = new_line
  end
}.output( :png => "#{$0}.png" )
