# http://www.graphviz.org/Gallery/directed/hello.html
#
# digraph G {Hello->World}

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( :G, :type => :digraph ) { |g|
  g.world( :label => "<World" ) << g.hello( :label => "Hello>" )
}.output( :svg => "#{$0}.svg" )