# http://www.graphviz.org/Gallery/directed/traffic_lights.gv.txt
#
# digraph TrafficLights {
#   node [shape=box];  gy2; yr2; rg2; gy1; yr1; rg1;
#   node [shape=circle,fixedsize=true,width=0.9];  green2; yellow2; red2; safe2; safe1; green1; yellow1; red1;
#   gy2->yellow2;
#   rg2->green2;
#   yr2->safe1;
#   yr2->red2;
#   safe2->rg2;
#   green2->gy2;
#   yellow2->yr2;
#   red2->rg2;
#   gy1->yellow1;
#   rg1->green1;
#   yr1->safe2;
#   yr1->red1;
#   safe1->rg1;
#   green1->gy1;
#   yellow1->yr1;
#   red1->rg1;
#
#   overlap=false
#   label="PetriNet Model TrafficLights\nExtracted from ConceptBase and layed out by Graphviz"
#   fontsize=12;
# }

$:.unshift( "../../lib" );
require "graphviz"

GraphViz::new( "TrafficLights", :type => :digraph ) { |g|
  g.gy2[:shape] = :box; g.yr2[:shape] = :box; g.rg2[:shape] = :box; g.gy1[:shape] = :box; g.yr1[:shape] = :box; g.rg1[:shape] = :box;
  g.green2.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.yellow2.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.red2.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.safe2.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.safe1.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.green1.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.yellow1.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }
  g.red1.set { |n| n[:shape] = :circle; n[:fixedsize] = :true; n[:width] = 0.9 }

  g.gy2 << g.yellow2
  g.rg2 << g.green2
  g.yr2 << g.safe1
  g.yr2 << g.red2
  g.safe2 << g.rg2
  g.green2 << g.gy2
  g.yellow2 << g.yr2
  g.red2 << g.rg2
  g.gy1 << g.yellow1
  g.rg1 << g.green1
  g.yr1 << g.safe2
  g.yr1 << g.red1
  g.safe1 << g.rg1
  g.green1 << g.gy1
  g.yellow1 << g.yr1
  g.red1 << g.rg1

  g[:overlap] = :false
  g[:label] = 'PetriNet Model TrafficLights\nExtracted from ConceptBase and layed out by Graphviz'
  g[:fontsize] = 12;
}.output( :errors => 1, :png => "#{$0}.png" )