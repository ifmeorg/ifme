require 'helper'

class GraphVizTest < Test::Unit::TestCase
  def setup
    @graph = GraphViz::new( :G )
  end

  def test_graph
    assert(@graph, 'Create graph faild.')

    assert_block 'Set attribut for graph faild.' do
      @graph['size'] = "10,10"
    end

    assert_equal( "\"10,10\"", @graph['size'].to_s, 'Get attribut for graph faild.' )

    assert_equal( "G", @graph.name, "Wrong graph name." )
  end

  def test_node
    n, m = nil, nil

    assert_block 'Create node failed.' do
      n = @graph.add_nodes( "n1" )
    end

    assert_block 'Get node failed.' do
      m = @graph.get_node( "n1" )
    end

    assert_equal( m, n, "Node corrupted when get." )

    assert_equal( @graph.node_count, 1, "Wrong number of nodes" )

    assert_block 'Set attribut for node faild.' do
      n['label'] = "Hello\n\"world\"\\l"
    end

    assert_equal( "\"Hello\\n\\\"world\\\"\\l\"", n['label'].to_s, 'Get attribut for node faild.' )
  end

  def test_search
     g = GraphViz::new( "G" )
     g.node["shape"] = "ellipse"
     g.node["color"] = "black"

     g["color"] = "black"

     c0 = g.add_graph( "cluster0" )
     c0["label"] = "process #1"
     c0["style"] = "filled"
     c0["color"] = "lightgrey"
     a0 = c0.add_nodes( "a0", "style" => "filled", "color" => "white" )
     a1 = c0.add_nodes( "a1", "style" => "filled", "color" => "white" )
     a2 = c0.add_nodes( "a2", "style" => "filled", "color" => "white" )
     a3 = c0.add_nodes( "a3", "style" => "filled", "color" => "white" )
     c0.add_edges( a0, a1 )
     c0.add_edges( a1, a2 )
     c0.add_edges( a2, a3 )

     c1 = g.add_graph( "cluster1", "label" => "process #2" )
     b0 = c1.add_nodes( "b0", "style" => "filled", "color" => "blue" )
     b1 = c1.add_nodes( "b1", "style" => "filled", "color" => "blue" )
     b2 = c1.add_nodes( "b2", "style" => "filled", "color" => "blue" )
     b3 = c1.add_nodes( "b3", "style" => "filled", "color" => "blue" )
     c1.add_edges( b0, b1 )
     c1.add_edges( b1, b2 )
     c1.add_edges( b2, b3 )

     start = g.add_nodes( "start", "shape" => "Mdiamond" )
     endn  = g.add_nodes( "end",   "shape" => "Msquare" )

     g.add_edges( start, a0 )
     g.add_edges( start, b0 )
     g.add_edges( a1, b3 )
     g.add_edges( b2, a3 )
     g.add_edges( a3, a0 )
     g.add_edges( a3, endn )

     assert g

     assert_equal g.get_node("start"), start
     assert_equal g.find_node("start"), start
     assert_equal g.search_node("start"), start

     assert_nil   g.get_node("a0")
     assert_equal g.find_node("a0"), a0
     assert_equal g.search_node("a0"), a0

     assert_nil   c0.get_node("start")
     assert_equal c0.find_node("start"), start
     assert_nil   c0.search_node("start")

     assert_equal c0.get_node("a0"), a0
     assert_equal c0.find_node("a0"), a0
     assert_equal c0.search_node("a0"), a0

     assert_nil   c1.get_node("start")
     assert_equal c1.find_node("start"), start
     assert_nil   c1.search_node("start")

     assert_nil   c1.get_node("a0")
     assert_equal c1.find_node("a0"), a0
     assert_nil   c1.search_node("a0")
  end

  def test_getting_escaped_node_from_edge
    @g = GraphViz.graph "G" do |g|
      g.add_nodes 'a@com'
      g.add_nodes 'b@com'
      g.add_edges 'a@com', 'b@com'
    end

    @g.each_edge do |e|
      assert_not_nil @g.get_node e.node_one(true, false)
      assert_not_nil @g.get_node e.node_two(true, false)
    end
  end

  def test_to_s
    assert_nothing_raised 'to_s with edge with numeric label failed.' do
      a = @graph.add_nodes('a')
      b = @graph.add_nodes('b')
      @graph.add_edges(a, b, :label => 5)
      @graph.to_s
    end
  end
end
