require 'rubygems'
require 'graphviz'

class GraphViz
  class FamilyTree
    class Person
      def initialize( graph, tree, generation, id ) #:nodoc:
        @graph = graph
        @node = @graph.add_nodes( id )
        @node["shape"] = "box"
        @tree = tree
        @generation = generation
        @x, @y = 0, 0
        @sibling = nil
      end

      def id
        @node.id
      end

      def name
        @node.label || @node.id
      end

      def sibling
        @sibling
      end

      def sibling=(x)
        @sibling=x
      end

      def couples #:nodoc:
        @couples
      end

      def node #:nodoc:
        @node
      end

      # Define the current person as a man
      #
      #  greg.is_a_man( "Greg" )
      def is_a_man( name )
        @node["label"] = name
        @node["color"] = "blue"
      end

      # Define the current person as a boy
      #
      #  greg.is_a_boy( "Greg" )
      def is_a_boy( name )
        is_a_man( name )
      end

      # Define the current perdon as a woman
      #
      #  mu.is_a_woman( "Muriel" )
      def is_a_woman( name )
        @node["label"] = name
        @node["color"] = "pink"
      end
      # Define the current perdon as a girl
      #
      #  maia.is_a_girl( "Maia" )
      def is_a_girl( name )
        is_a_woman( name )
      end

      # Define that's two persons are maried
      #
      #  mu.is_maried_with greg
      def is_maried_with( x )
        node = @graph.add_nodes( "#{@node.id}And#{x.node.id}" )
        node["shape"] = "point"
        @graph.add_edges( @node, node, "dir" => "none" )
        @graph.add_edges( node, x.node, "dir" => "none" )
        @tree.add_couple( self, x, node )
      end

      # Define that's two persons are divorced
      #
      #  sophie.is_divorced_with john
      def is_divorced_with( x )
        node = @graph.add_nodes( "#{@node.id}And#{x.node.id}" )
        node["shape"] = "point"
        node["color"] = "red"
        @graph.add_edges( @node, node, "dir" => "none", "color" => "red" )
        @graph.add_edges( node, x.node, "dir" => "none", "color" => "red" )
        @tree.add_couple( self, x, node )
      end

      # Define that's a person is widower of another
      #
      #  simon.is_widower_of elisa
      def is_widower_of( x ) #veuf
        node = @graph.add_nodes( "#{@node.id}And#{x.node.id}" )
        node["shape"] = "point"
        node["color"] = "green"
        @graph.add_edges( @node, node, "dir" => "none", "color" => "green" )
        @graph.add_edges( node, x.node, "dir" => "none", "color" => "green" )
        @tree.add_couple( self, x, node )
      end

      # Define the current person as dead
      #
      #  jack.is_dead
      def is_dead
        @node["style"] = "filled"
      end

      # Define the kids of a single person
      #
      #   alice.kids( john, jack, julie )
      def kids( *z )
        GraphViz::FamilyTree::Couple.new( @graph, @node, [self] ).kids( *z )
      end
    end
  end
end
