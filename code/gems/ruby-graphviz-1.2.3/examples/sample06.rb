$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "G", :rankdir => "LR", :type => "graph" ) { |graph|
  graph.cluster0 { |cluster|
    cluster[:label] = "Back Office"

    cluster.fatman.set { |n|
      n.label = "FatMan"
      n.shape = "rect"
    }
    cluster.grobil.set { |n|
      n.label = "GroBil"
      n.shape = "rect"
    }
  }

  graph.cluster1 { |cluster|
    cluster[:label] = "DMZ"

    cluster.dupont.set { |n|
      n.label = "Dupont"
      n.shape = "rect"
    }
    cluster.dupond.set { |n|
      n.label = "Dupond"
      n.shape = "rect"
    }
  }

  graph.cluster2() { |cluster|
    cluster[:label] = "Front Office"

    cluster.door.set { |n|
      n.label = "Door"
      n.shape = "rect"
    }
  }

  graph.cluster0.fatman << graph.cluster1.dupont
  graph.cluster0.fatman << graph.cluster1.dupond
  graph.cluster0.grobil << graph.cluster1.dupont
  graph.cluster0.grobil << graph.cluster1.dupond
  graph.cluster1.dupont << graph.cluster2.door
  graph.cluster1.dupond << graph.cluster2.door
}.output( :path => '/usr/local/bin/', :png => "#{$0}.png" )