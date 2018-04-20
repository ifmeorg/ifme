require 'helper'

class GraphVizSubGraphTest < Test::Unit::TestCase
  def test_subgraph
    master1 = GraphViz::new(:G)
    master1.add_graph('cluster_cl1')

    master2 = GraphViz::new(:G)
    cl2 = GraphViz::new('cluster_cl1')
    master2.add_graph cl2

    assert_equal(master1.to_s, master2.to_s, "Wrong subgraph")
  end

  def test_to_graph
    m = GraphViz.new(:G)
    m.add_edges("m1", "m2")
    c = m.add_graph('c')
    c.add_edges("c1", "c2")

    assert_equal true, c.has_parent_graph?
    assert_equal false, m.has_parent_graph?

    ci = c.to_graph
    assert_equal false, ci.has_parent_graph?
  end
end
