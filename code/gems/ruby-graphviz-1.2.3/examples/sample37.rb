$:.unshift( "../lib" )
require "graphviz"

# The goal is to set each planet to its own orbit + set some (earth+moon) to the same orbit

g = GraphViz::new( "Solarsys",
 :type => "digraph",
 :use => "twopi"
)

# the star
sun  = g.add_nodes(
 'Sun',
 :shape => "circle",
 :penwidth => 2,
 :fontsize => 12,
 :style => :filled,
 :fillcolor => "orange",
 :label => "Sun\n"
)

planets = Hash.new

# The Earth and the Moon - in the same subgraph\rank
g.subgraph { |c|
 c[:rank => 'same']
 planets['Moon']  = c.add_nodes(
   'Moon',
   :shape => "circle",
   :penwidth => 2,
   :fontsize => 12,
   :style => :filled,
   :fillcolor => "red",
   :label => "Moon\n"
 )
 planets['Earth']  = c.add_nodes(
   'Earth',
   :shape => "circle",
   :penwidth => 2,
   :fontsize => 12,
   :style => :filled,
   :fillcolor => "blue",
   :label => "Earth\n"
 )
 c.add_edges( planets['Moon'], planets['Earth'],
   :penwidth => 2,
   :labeltooltip => "distance",
   :color => "black"
 )


}

g.add_edges( sun, planets['Earth'],
  :penwidth => 2,
  :labeltooltip => "distance",
  :color => "black"
)

i = 0
# some more planets - each supposed having its own orbit - im trying to do it with rank
['Mercury','Venus','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto'].each { |p|
  i = i + 1
 # set each to its own orbit
 # that doesnt seem to work ...
 g.subgraph { |c|
   c[:rank => "same"]
   planets[p] = c.add_nodes(
     p,
     :shape => "circle",
     :penwidth => 2,
     :fontsize => 12,
     :fillcolor => "green",
     :style => :filled,
     :label => "#{p}\n"
   )
   c.add_edges( sun, planets[p],
     :penwidth => 2,
     :label => "distance",
     :color => "black"
   )
 }

}

g.output( :png => "#{$0}.png" )
g.output( :none => "#{$0}.dot" )
