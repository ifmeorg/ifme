require 'graphviz/math/matrix'

class GraphViz
   class Theory
      def initialize( graph )
         @graph = graph
      end

      # Return the adjancy matrix of the graph
      def adjancy_matrix
         matrix = GraphViz::Math::Matrix.new( @graph.node_count, @graph.node_count )

         @graph.each_edge { |e|
            x = @graph.get_node(e.node_one(false, false)).index
            y = @graph.get_node(e.node_two(false, false)).index
            matrix[x+1, y+1] = 1
            matrix[y+1, x+1] = 1 if @graph.type == "graph"
         }

         return matrix
      end

      # Return the incidence matrix of the graph
      def incidence_matrix
         tail = (@graph.type == "digraph") ? -1 : 1
         matrix = GraphViz::Math::Matrix.new( @graph.node_count, @graph.edge_count )

         @graph.each_edge { |e|
            x = e.index

            nstart = @graph.get_node(e.node_one(false, false)).index
            nend = @graph.get_node(e.node_two(false, false)).index

            matrix[nstart+1, x+1] = 1
            matrix[nend+1, x+1] = tail
            matrix[nend+1, x+1] = 2 if nstart == nend
         }

         return matrix
      end

      # Return the degree of the given node
      def degree( node )
         degree = 0
         name = node
         if node.kind_of?(GraphViz::Node)
            name = node.id
         end

         @graph.each_edge do |e|
            degree += 1 if e.node_one(false, false) == name or e.node_two(false, false) == name
         end

         return degree
      end

      # Return the laplacian matrix of the graph
      def laplacian_matrix
         return degree_matrix - adjancy_matrix
      end

      # Return <tt>true</tt> if the graph if symmetric, <tt>false</tt> otherwise
      def symmetric?
         adjancy_matrix == adjancy_matrix.transpose
      end

      # moore_dijkstra(source, destination)
      def moore_dijkstra( dep, arv )
         dep = @graph.get_node(dep) unless dep.kind_of?(GraphViz::Node)
         arv = @graph.get_node(arv) unless arv.kind_of?(GraphViz::Node)

         m = distance_matrix
         n = @graph.node_count
         # Table des sommets à choisir
         c = [dep.index]
         # Table des distances
         d = []
         d[dep.index] = 0

         # Table des predecesseurs
         pred = []

         @graph.each_node do |name, k|
            if k != dep
               d[k.index] = m[dep.index+1,k.index+1]
               pred[k.index] = dep
            end
         end

         while c.size < n
            # trouver y tel que d[y] = min{d[k];  k sommet tel que k n'appartient pas à c}
            mini = 1.0/0.0
            y = nil
            @graph.each_node do |name, k|
               next if c.include?(k.index)
               if d[k.index] < mini
                  mini = d[k.index]
                  y = k
               end
            end

            # si ce minimum est ∞ alors sortir de la boucle fin si
            break unless mini.to_f.infinite?.nil?

            c << y.index
            @graph.each_node do |name, k|
               next if c.include?(k.index)
               if d[k.index] > d[y.index] + m[y.index+1,k.index+1]
                  d[k.index] = d[y.index] + m[y.index+1,k.index+1]
                  pred[k.index] = y
               end
            end
         end

         # Construction du chemin le plus court
         ch = []
         k = arv
         while k.index != dep.index
            ch.unshift(k)
            k = pred[k.index]
         end
         ch.unshift(dep)

         if d[arv.index].to_f.infinite?
            return nil
         else
            return( {
               :path => ch,
               :distance => d[arv.index]
            } )
         end
      end

      # Return a liste of range
      #
      # If the returned array include nil values, there is one or more circuits in the graph
      def range
         matrix = adjancy_matrix
         unseen = (1..matrix.columns).to_a
         result = Array.new(matrix.columns)
         r = 0

         range_recursion( matrix, unseen, result, r )
      end

      # Return the critical path for a PERT network
      #
      # If the given graph is not a PERT network, return nul
      def critical_path
         return nil if range.include?(nil) or @graph.type != "digraph"
         r = [ [0, [1]] ]

         critical_path_recursion( distance_matrix, adjancy_matrix, r, [], 0 ).inject( {:distance => 0, :path => []} ) { |_r, item|
            (_r[:distance] < item[0]) ? { :distance => item[0], :path => item[1] } : _r
         }
      end

      # Return the PageRank in an directed graph.
      #
      # * damping_factor: PageRank dumping factor.
      # * max_iterations: Maximum number of iterations.
      # * min_delta: Smallest variation required to have a new iteration.
      def pagerank(damping_factor = 0.85, max_iterations = 100, min_delta = 0.00001)
         return nil unless @graph.directed?

         min_value = (1.0-damping_factor)/@graph.node_count

         pagerank = {}
         @graph.each_node { |_, node|
            pagerank[node] = 1.0/@graph.node_count
         }

         max_iterations.times { |_|
            diff = 0
            @graph.each_node { |_, node|
               rank = min_value
               incidents(node).each { |referent|
                  rank += damping_factor * pagerank[referent] / neighbors(referent).size
               }

               diff += (pagerank[node] - rank).abs
               pagerank[node] = rank
            }
            break if diff < min_delta
         }

         return pagerank
      end

      # Return the list of nodes that are directly accessible from given node
      def neighbors(node)
         if node.class == String
            @graph.get_node(node).neighbors
         else
            node.neighbors
         end
      end

      # Return the list of nodes that are incident to the given node (in a directed graph neighbors == incidents)
      def incidents(node)
         if node.class == String
            @graph.get_node(node).incidents
         else
            node.incidents
         end
      end

      # Breadth First Search
      def bfs(node, &b)
         queue = []
         visited_nodes = []
         node = @graph.get_node(node) if node.kind_of? String
         queue << node
         visited_nodes << node

         while not queue.empty?
            node = queue.shift
            b.call(node)
            neighbors(node).each do |n|
               unless visited_nodes.include?(n)
                  visited_nodes << n
                  queue << n
               end
            end
         end
      end

      # Depth First Search
      def dfs(node, &b)
         visited_nodes = []
         recursive_dfs(node, visited_nodes, &b)
      end

      private
      def recursive_dfs(node, visited_nodes, &b)
         node = @graph.get_node(node) if node.kind_of? String
         b.call(node)
         visited_nodes << node
         neighbors(node).each do |n|
            recursive_dfs(n, visited_nodes, &b) unless visited_nodes.include?(n)
         end
      end

      def distance_matrix
         type = @graph.type
         matrix = GraphViz::Math::Matrix.new( @graph.node_count, @graph.node_count, (1.0/0.0) )

         @graph.each_edge { |e|
            x = @graph.get_node(e.node_one(false, false)).index
            y = @graph.get_node(e.node_two(false, false)).index
            unless x == y
               weight = ((e[:weight].nil?) ? 1 : e[:weight].to_f)
               matrix[x+1, y+1] = weight
               matrix[y+1, x+1] = weight if type == "graph"
            end
         }

         return matrix
      end

      def degree_matrix
         matrix = GraphViz::Math::Matrix.new( @graph.node_count, @graph.node_count )
         @graph.each_node do |name, node|
            i = node.index
            matrix[i+1, i+1] = degree(node)
         end
         return matrix
      end

      def range_recursion(matrix, unseen, result, r)
         remove = []
         matrix.columns.times do |c|
            if matrix.sum_of_column(c+1) == 0
               result[unseen[c]-1] = r
               remove.unshift( c + 1 )
            end
         end

         remove.each do |rem|
            matrix = matrix.remove_line(rem).remove_column(rem)
            unseen.delete_at(rem-1)
         end

         if matrix.columns == 1 and matrix.lines == 1
            if matrix.sum_of_column(1) == 0
               result[unseen[0]-1] = r+1
            end
         elsif remove.size > 0
            range_recursion( matrix, unseen, result, r+1 )
         end

         return result
      end

      def index_of_item( array, item )
         array.inject( [0,[]] ){|a,i|
            a[1] << a[0] if i == item
            a[0] += 1
            a
         }[1]
      end

      def critical_path_recursion( d, a, r, result, level )
         r.each do |p|
            node = p[1][-1]
            index_of_item( a.line(node), 1 ).each do |c|
               succ = c+1

               cpath = [ (p[0] + d[node,succ]), (p[1].clone << succ) ]

               if index_of_item( a.line(succ), 1 ).size > 0
                  critical_path_recursion( d, a, [cpath], result, level+1 )
               else
                  result << cpath
               end
            end
         end
         return result
      end
   end
end
