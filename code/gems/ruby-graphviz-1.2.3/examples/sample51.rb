# http://www.graphviz.org/Gallery/undirected/process.html
#
# graph G {
# 	run -- intr;
# 	intr -- runbl;
# 	runbl -- run;
# 	run -- kernel;
# 	kernel -- zombie;
# 	kernel -- sleep;
# 	kernel -- runmem;
# 	sleep -- swap;
# 	swap -- runswap;
# 	runswap -- new;
# 	runswap -- runmem;
# 	new -- runmem;
# 	sleep -- runmem;
# }

$:.unshift( "../../lib" );
require "graphviz"

GraphViz::new( :G, :type => :graph ) { |g|
  g._new[:label] = "new"
  g.run << g.intr
  g.intr << g.runbl
  g.runbl << g.run
  g.run << g.kernel
  g.kernel << g.zombie
  g.kernel << g.sleep
  g.kernel << g.runmem
  g.sleep << g.swap
  g.swap << g.runswap
  g.runswap << g._new
  g.runswap << g.runmem
  g._new << g.runmem
  g.sleep << g.runmem
}.output( :png => "#{$0}.png", :use => :fdp )