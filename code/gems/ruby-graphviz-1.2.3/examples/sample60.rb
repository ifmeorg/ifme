#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

asm = GraphViz::new( "My ASM" )

my = asm.add_nodes("My")
asmn = asm.add_nodes("ASM")
asm.add_edges(my, asmn)

asm.output( :png => "#{$0}.png" )
