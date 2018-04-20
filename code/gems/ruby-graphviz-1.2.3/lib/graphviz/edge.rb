# Copyright (C) 2004 - 2012 Gregoire Lejeune <gregoire.lejeune@free.fr>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA

require 'graphviz/attrs'
require 'graphviz/constants'

class GraphViz
  class Edge
    include GraphViz::Constants

    # Create a new edge
    #
    # In:
    # * vNodeOne : First node (can be a GraphViz::Node or a node ID)
    # * vNodeTwo : Second node (can be a GraphViz::Node or a node ID)
    # * parent_graph : Graph
    def initialize( vNodeOne, vNodeTwo, parent_graph )
      @node_one_id, @node_one_port = getNodeNameAndPort( vNodeOne )
      @node_two_id, @node_two_port = getNodeNameAndPort( vNodeTwo )

      @parent_graph = parent_graph
      @edge_attributes = GraphViz::Attrs::new( nil, "edge", EDGESATTRS )
      @index = nil

      unless @parent_graph.directed?
        (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id)).incidents << (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id))
        (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id)).neighbors << (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id))
      end
      (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id)).neighbors << (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id))
      (@parent_graph.find_node(@node_two_id) || @parent_graph.add_nodes(@node_two_id)).incidents << (@parent_graph.find_node(@node_one_id) || @parent_graph.add_nodes(@node_one_id))
    end

    # Return the node one as string (so with port if any)
    def node_one(with_port = true, escaped = true)
      if not(@node_one_port and with_port)
        escaped ? GraphViz.escape(@node_one_id) : @node_one_id
      else
        escaped ? GraphViz.escape(@node_one_id, :force => true) + ":#{@node_one_port}" : "#{@node_one_id}:#{@node_one_port}"
      end
    end
    alias :tail_node :node_one

    # Return the node two as string (so with port if any)
    def node_two(with_port = true, escaped = true)
      if not(@node_two_port and with_port)
        escaped ? GraphViz.escape(@node_two_id) : @node_two_id
      else
        escaped ? GraphViz.escape(@node_two_id, :force => true) + ":#{@node_two_port}" : "#{@node_two_id}:#{@node_two_port}"
      end
    end
    alias :head_node :node_two

    # Return the index of the edge
    def index
      @index
    end
    def index=(i) #:nodoc:
      @index = i if @index == nil
    end

    # Set value +attribute_value+ to the edge attribute +attribute_name+
    def []=( attribute_name, attribute_value )
      attribute_value = attribute_value.to_s if attribute_value.class == Symbol
      @edge_attributes[attribute_name.to_s] = attribute_value
    end

    # Set values for edge attributes or
    # get the value of the given edge attribute +attribute_name+
    def []( attribute_name )
      # Modification by axgle (https://github.com/axgle)
      if Hash === attribute_name
        attribute_name.each do |key, value|
          self[key] = value
        end
      else
        if @edge_attributes[attribute_name.to_s]
          @edge_attributes[attribute_name.to_s].clone
        else
          nil
        end
      end
    end

    #
    # Calls block once for each attribute of the edge, passing the name and value to the
    # block as a two-element array.
    #
    # If global is set to false, the block does not receive the attributes set globally
    #
    def each_attribute(global = true, &b)
      attrs = @edge_attributes.to_h
      if global
        attrs = pg.edge.to_h.merge attrs
      end
      attrs.each do |k,v|
        yield(k,v)
      end
    end
    def each_attribut(global = true, &b)
      warn "`GraphViz::Edge#each_attribut` is deprecated, please use `GraphViz::Edge#each_attribute`"
      each_attribute(global, &b)
    end

    def <<( node ) #:nodoc:
      n = @parent_graph.get_node(@node_two_id)

      GraphViz::commonGraph( node, n ).add_edges( n, node )
    end
    alias :> :<< #:nodoc:
    alias :- :<< #:nodoc:
    alias :>> :<< #:nodoc:

    #
    # Return the root graph
    #
    def root_graph
      return( (self.pg.nil?) ? nil : self.pg.root_graph )
    end

    def pg #:nodoc:
      @parent_graph
    end

    # Set edge attributes
    #
    # Example :
    #   e = graph.add_edges( ... )
    #   ...
    #   e.set { |_e|
    #     _e.color = "blue"
    #     _e.fontcolor = "red"
    #   }
    def set( &b )
      yield( self )
    end

    # Add edge options
    # use edge.<option>=<value> or edge.<option>( <value> )
    def method_missing( idName, *args, &block ) #:nodoc:
      return if idName == :to_ary # ruby 1.9.2 fix
      xName = idName.id2name

      self[xName.gsub( /=$/, "" )]=args[0]
    end

    def output( oGraphType ) #:nodoc:
      xLink = " -> "
      if oGraphType == "graph"
        xLink = " -- "
      end

      # reserved words, they aren't accepted in dot as node name
      reserved_names = ["node", "edge","graph", "digraph", "subgraph", "strict"]

      xOut = reserved_names.include?(self.node_one) ? "" << "_" + self.node_one : "" << self.node_one
      xOut = xOut << xLink
      xOut = reserved_names.include?(self.node_two) ? xOut << "_" + self.node_two : xOut << self.node_two
      xAttr = ""
      xSeparator = ""
      @edge_attributes.data.each do |k, v|
        xAttr << xSeparator + k + " = " + v.to_gv
        xSeparator = ", "
      end
      if xAttr.length > 0
        xOut << " [" + xAttr + "]"
      end
      xOut << ";"

      return( xOut )
    end

    private
    def getNodeNameAndPort( node )
      name, port = nil, nil
      if node.class == Hash
        node.each do |k, v|
          name, port = getNodeNameAndPort(k)
          port = v
        end
      elsif node.class == String
        name = node
      else
        name = node.id
      end

      return name, port
    end
  end
end
