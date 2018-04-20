class GraphViz
  class FamilyTree
    class Couple
      def initialize( graph, node, persons ) #:nodoc:
        @graph = graph
        @node = node
        @kids = []
        @persons = persons
      end

      def node #:nodoc:
        @node
      end

      # Add kids to a couple
      def kids( *z )
        @kids = GraphViz::FamilyTree::Sibling.new( z, @persons )

        return

        if z.size == 1
          @graph.add_edges( @node, z[0].node, "dir" => "none" )
        else
          cluster = @graph.add_graph( "#{@node.id}Kids" )
          cluster["rank"] = "same"

          last = nil
          count = 0
          add = (z.size-1)%2 * z.size/2 + (z.size-1)%2
          link = (z.size/2)+1

          z.each do |person|
            count = count + 1
            if count == add
              middle = cluster.add_nodes( "#{@node.id}Kids", "shape" => "point" )
              @graph.add_edges( @node, middle, "dir" => "none" )
              unless last.nil?
                cluster.add_edges( last, middle, "dir" => "none" )
              end
              last = middle
            end

            kid = cluster.add_nodes( "#{person.node.id}Kid", "shape" => "point" )
            @graph.add_edges( kid, person.node, "dir" => "none" )

            if add == 0 and count == link
              @graph.add_edges( @node, kid, "dir" => "none" )
            end

            unless last.nil?
              cluster.add_edges( last, kid, "dir" => "none" )
            end
            last = kid
          end
        end
      end

      def getKids
        @kids
      end
    end
  end
end
