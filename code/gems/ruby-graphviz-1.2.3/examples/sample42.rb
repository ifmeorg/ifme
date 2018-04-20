#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", "path" => ARGV[0], :use => "circo" )
else
  g = GraphViz::new( "G" )
end

c0 = g.add_graph( "cluster0" )
c0["label"] = "Environnement de Brad !"
c0["style"] = "filled"
c0["color"] = "blue"

ja = c0.add_nodes( "Jennifer_Aniston", :style => "filled", :color => "red" )
bp = c0.add_nodes( "Brad_Pitt", :style => "filled", :color => "white" )
aj = c0.add_nodes( "Angelina_Jolie", :style => "filled", :color => "green" )

c0.add_edges( ja, bp ) # On ete mariés
c0.add_edges( bp, aj ) # Sont ensemble

jv = g.add_nodes( "John_Voight", :label => "John Voight", :shape => "rectangle" )
md = g.add_nodes( "Madonna" )
gr = g.add_nodes( "Guy_Ritchie" )

g.add_edges( aj, jv ) # est la fille de
g.add_edges( jv, aj ) # est le pere de
g.add_edges( bp, jv, :color => "red", :label => "Est le beau fils de" ) # Beau fils
g.add_edges( bp, gr )
g.add_edges( gr, md )

g.output( :png => "#{$0}.png" )
