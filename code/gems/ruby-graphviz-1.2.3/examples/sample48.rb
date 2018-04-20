# http://www.graphviz.org/Gallery/directed/cluster.html
#
# digraph G {
#
# 	subgraph cluster_0 {
# 		style=filled;
# 		color=lightgrey;
# 		node [style=filled,color=white];
# 		a0 -> a1 -> a2 -> a3;
# 		label = "process #1";
# 	}
#
# 	subgraph cluster_1 {
# 		node [style=filled];
# 		b0 -> b1 -> b2 -> b3;
# 		label = "process #2";
# 		color=blue
# 	}
# 	start -> a0;
# 	start -> b0;
# 	a1 -> b3;
# 	b2 -> a3;
# 	a3 -> a0;
# 	a3 -> end;
# 	b3 -> end;
#
# 	start [shape=Mdiamond];
# 	end [shape=Msquare];
# }

$:.unshift( "../lib" );
require "graphviz"

GraphViz.new( :G, :type => :digraph ) { |g|
  g.cluster_0 { |c|
    c[:style] = :filled
    c[:color] = :lightgrey
    c.node[:style] = :filled
    c.node[:color] = :white
    c.a0 << c.a1 << c.a2 << c.a3
    c[:label] = "process #1"
  }

  g.cluster_1 { |c|
     c.node[:style] = :filled
     c.b0 << c.b1 << c.b2 << c.b3
     c[:label] = "process #1"
     c[:color] = :blue
  }

  g.start << g.cluster_0.a0
  g.start << g.cluster_1.b0
  g.cluster_0.a1 << g.cluster_1.b3
  g.cluster_1.b2 << g.cluster_0.a3
  g.cluster_0.a3 << g.cluster_0.a0
  g.cluster_0.a3 << g._end
  g.cluster_1.b3 << g._end

  g.start[:shape] = :Mdiamond
  g._end[:label] = "end"
  g._end[:shape] = :Mdiamond
}.output( :png => "#{$0}.png" )
