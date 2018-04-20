#!/usr/bin/ruby

$:.unshift( "../lib" )
require "graphviz"

g = nil
if ARGV[0]
  g = GraphViz::new( "G", :path => ARGV[0] )
else
  g = GraphViz::new( "G" )
end

g.add_nodes "HtmlOne", label: '<<b>This</b> is an<br/>HTML Node>'
g.add_nodes "HtmlTwo", label: '<This is also<br/>an HTML node>'
g.add_nodes "NotHtmlOne", label: '<this is not an HTML node>'
g.add_nodes "NotHtmlTwo", label: 'this is not an HTML node, too!'

g.output( :png => "#{$0}.png" )
