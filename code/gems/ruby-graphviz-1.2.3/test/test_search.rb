require 'helper'

class GraphVizSearch < Test::Unit::TestCase
   def setup
      @graph = GraphViz.graph(:G)
      @graph.add_nodes(["A", "B", "C", "D", "E", "F", "G"])
      @graph.add_edges("A", ["B", "C", "E"])
      @graph.add_edges("B", ["D", "F"])
      @graph.add_edges("C", "G")
      @graph.add_edges("F", "E")
      @theory = GraphViz::Theory.new(@graph)
   end

   def test_dfs
      order = []
      @theory.dfs("A") { |node|
         order << node.id
      }
      assert_equal order, ["A", "B", "D", "F", "E", "C", "G"]
   end

   def test_bfs
      order = []
      @theory.bfs("A") { |node|
         order << node.id
      }
      assert_equal order, ["A", "B", "C", "E", "D", "F", "G"]
   end
end
