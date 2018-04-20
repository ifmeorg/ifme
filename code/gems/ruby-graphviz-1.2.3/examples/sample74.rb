#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", :path => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g.add_nodes "english", label: 'hello'
g.add_nodes "chinese", label: '你好'
g.add_nodes "korean", label: '안녕하세요'
g.add_nodes "arabic", label: 'مرحبا'
g.add_nodes "russian", label: 'Алло'

g.output( :png => "#{$0}.png" )
