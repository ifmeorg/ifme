#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", "path" => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g["rankdir"] = "LR"
g.node["shape"] = "ellipse"
g.edge["arrowhead"] = "normal"

[
"box",
"boxbox",
"lbox",
"lboxlbox",
"rbox",
"rboxrbox",
"olbox",
"olboxolbox",
"orbox",
"orboxorbox",
"obox",
"oboxobox",
"crow",
"crowcrow",
"lcrow",
"lcrowlcrow",
"rcrow",
"rcrowrcrow",
"diamond",
"diamonddiamond",
"ldiamond",
"ldiamondldiamond",
"rdiamond",
"rdiamondrdiamond",
"oldiamond",
"oldiamondoldiamond",
"ordiamond",
"ordiamondordiamond",
"odiamond",
"odiamondodiamond",
"dot",
"dotdot",
"odot",
"odotodot",
"inv",
"invinv",
"linv",
"linvlinv",
"rinv",
"rinvrinv",
"olinv",
"olinvolinv",
"orinv",
"orinvorinv",
"oinv",
"oinvoinv",
"none",
"nonenone",
"normal",
"normalnormal",
"lnormal",
"lnormallnormal",
"rnormal",
"rnormalrnormal",
"olnormal",
"olnormalolnormal",
"ornormal",
"ornormalornormal",
"onormal",
"onormalonormal",
"tee",
"teetee",
"ltee",
"lteeltee",
"rtee",
"rteertee",
"vee",
"veevee",
"lvee",
"lveelvee",
"rvee",
"rveervee"
].each { |s|
  p = "p_" << s
  g.add_nodes( p, "shape" => "point" )
  g.add_nodes( s )
  g.add_edges( p, s, "arrowhead" => s )
}

g.output( :png => "#{$0}.png" )
