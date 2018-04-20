require 'helper'

class GraphVizTheoryTest < Test::Unit::TestCase
   def setup
      @g = GraphViz.digraph( "G", :path => "/usr/local/bin" ) do |g|
         g.a[:label => "1"]
         g.b[:label => "2"]
         g.c[:label => "3"]
         g.d[:label => "4"]
         g.e[:label => "5"]
         g.f[:label => "6"]

         g.a << g.b
         g.a << g.d
         (g.a << g.f)[:weight => 6, :label => "6"]
         g.b << g.c
         g.b << g.d
         g.b << g.e
         g.c << g.d
         (g.c << g.f)[:weight => 2, :label => "2"]
         g.d << g.e
      end

      @t = GraphViz::Theory.new( @g )
   end

   def test_theory
      assert @g, "Create graph failed!"
      assert @t, "Theory failed!"
   end

   def test_adgency_matrix
      adgency = GraphViz::Math::Matrix.new([
        [0,1,0,1,0,1],
        [0,0,1,1,1,0],
        [0,0,0,1,0,1],
        [0,0,0,0,1,0],
        [0,0,0,0,0,0],
        [0,0,0,0,0,0]
      ])
      assert_equal @t.adjancy_matrix, adgency, "Wrong adgency matrix"
   end

   def test_symetric
      assert_equal false, @t.symmetric?
   end

   def test_incidence_matrix
      incidence = GraphViz::Math::Matrix.new([
         [ 1, 1, 1, 0, 0, 0, 0, 0, 0],
         [-1, 0, 0, 1, 1, 1, 0, 0, 0],
         [ 0, 0, 0,-1, 0, 0, 1, 1, 0],
         [ 0,-1, 0, 0,-1, 0,-1, 0, 1],
         [ 0, 0, 0, 0, 0,-1, 0, 0,-1],
         [ 0, 0,-1, 0, 0, 0, 0,-1, 0]
      ])
      assert_equal @t.incidence_matrix, incidence
   end

   def test_degree
      assert_equal 3, @t.degree(@g.get_node("a"))
      assert_equal 4, @t.degree(@g.get_node("b"))
      assert_equal 3, @t.degree(@g.get_node("c"))
      assert_equal 4, @t.degree(@g.get_node("d"))
      assert_equal 2, @t.degree(@g.get_node("e"))
      assert_equal 2, @t.degree(@g.get_node("f"))
   end

   def test_laplacian_matrix
      laplacian = GraphViz::Math::Matrix.new([
         [3,-1, 0,-1, 0,-1],
         [0, 4,-1,-1,-1, 0],
         [0, 0, 3,-1, 0,-1],
         [0, 0, 0, 4,-1, 0],
         [0, 0, 0, 0, 2, 0],
         [0, 0, 0, 0, 0, 2]
      ])
      assert_equal @t.laplacian_matrix, laplacian
   end

   def test_dijkstra_a_f
      r = @t.moore_dijkstra(@g.a, @g.f)
      assert r
      assert_equal ["a", "b", "c", "f"], r[:path].map{|n| n.id}
      assert_equal 4.0, r[:distance]
   end

   def test_range
      assert_equal [0, 1, 2, 3, 4, 3], @t.range
   end

   def test_critical_path
      r = @t.critical_path
      assert r
      assert_equal [1, 6], r[:path]
      assert_equal 6.0, r[:distance]
   end

   def test_escaped_node_ids__adjancy_matrix
      @g = GraphViz.graph "G" do |g|
         g.add_nodes 'a@com'
         g.add_nodes 'b@com'
         g.add_edges 'a@com', 'b@com'
      end

      @t = GraphViz::Theory.new( @g )

      assert_nothing_raised NoMethodError do
         @t.adjancy_matrix
      end
   end
end
