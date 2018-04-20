# Copyright (C) 2004 - 2011 Gregoire Lejeune <gregoire.lejeune@free.fr>
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
   class Node
      include GraphViz::Constants

      # List of nodes that are directly accessible from given node (in a directed graph neighbors == incidents)
      attr_reader :neighbors
      # List of nodes that are incident to the given node (in a directed graph neighbors == incidents)
      attr_reader :incidents

      # Create a new node
      #
      # * node_id : ID of the node
      # * parent_graph : Graph
      def initialize( node_id, parent_graph )
         @neighbors = []
         @incidents = []
         @node_id = node_id
         @parent_graph = parent_graph
         @node_attributes = GraphViz::Attrs::new( nil, "node", NODESATTRS )
         @index = nil
      end

      # Get the node ID
      def id
         @node_id.clone
      end

      # Return the node index
      def index
         @index
      end
      def index=(i) #:nodoc:
         @index = i if @index == nil
      end

      # Return the root graph
      def root_graph
         return( (self.pg.nil?) ? nil : self.pg.root_graph )
      end

      # Set value +attribute_value+ to the node attribute +attribute_name+
      def []=( attribute_name, attribute_value )
         attribute_value = attribute_value.to_s if attribute_value.class == Symbol
         @node_attributes[attribute_name.to_s] = attribute_value
      end

      # Get the value of the node attribute +attribute_name+
      def []( attribute_name )
         if Hash === attribute_name
            attribute_name.each do |key, value|
               self[key] = value
            end
            return self
         else
            (@node_attributes[attribute_name.to_s].nil?)?nil:@node_attributes[attribute_name.to_s].clone
         end
      end

      # Calls block once for each attribute of the node, passing the name and value to the
      # block as a two-element array.
      #
      # If global is set to false, the block does not receive the attributes set globally
      def each_attribute(global = true, &b)
         attrs = @node_attributes.to_h
         if global
            attrs = pg.node.to_h.merge attrs
         end
         attrs.each do |k,v|
            yield(k,v)
         end
      end
      def each_attribut(global = true, &b)
         warn "`GraphViz::Node#each_attribut` is deprecated, please use `GraphViz::Node#each_attribute`"
         each_attribute(global, &b)
      end

      # Create an edge between the current node and the node +node+
      def <<( node )
         if( node.class == Array )
            node.each do |no|
               self << no
            end
         else
            return GraphViz::commonGraph( node, self ).add_edges( self, node )
         end
      end
      alias :> :<<
      alias :- :<<
      alias :>> :<<

      # Set node attributes
      #
      # Example :
      #   n = graph.add_nodes( ... )
      #   ...
      #   n.set { |_n|
      #     _n.color = "blue"
      #     _n.fontcolor = "red"
      #   }
      #
      def set( &b )
         yield( self )
      end

      # Add node options
      # use node.<option>=<value> or node.<option>( <value> )
      def method_missing( idName, *args, &block ) #:nodoc:
         xName = idName.id2name

         self[xName.gsub( /=$/, "" )]=args[0]
      end

      def pg #:nodoc:
         @parent_graph
      end

      def output #:nodoc:
         # reserved words, they aren't accepted in dot as node name
         reserved_names = ["node", "edge","graph", "digraph", "subgraph", "strict"]
         #node_id = @node_id.clone
         #node_id = '"' << node_id << '"' if node_id.match( /^[a-zA-Z_]+[a-zA-Z0-9_\.]*$/ ).nil?
         node_id = GraphViz.escape(@node_id)

         # add a check to see if the node names are valid
         # if they aren't is added an _ before
         # and the print staies the same, because of the label
         xOut = reserved_names.include?(node_id) ? "" << "_" + node_id : "" << node_id
         xAttr = ""
         xSeparator = ""

         if @node_attributes.data.has_key?("label") and @node_attributes.data.has_key?("html")
            @node_attributes.data.delete("label")
         end
         @node_attributes.data.each do |k, v|
            xAttr << xSeparator + k + " = " + v.to_gv
            xSeparator = ", "
         end
         if xAttr.length > 0
            xOut << " [" + xAttr + "]"
         end
         xOut << ";"

         return( xOut )
      end
   end
end
