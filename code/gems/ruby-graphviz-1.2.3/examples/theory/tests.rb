$:.unshift( "../../lib" )
require 'graphviz'
require 'graphviz/theory'

g = GraphViz.digraph( "G", :path => "/usr/local/bin" ) do |g|
  g.a[:label => "1"]
  g.b[:label => "2"]
  g.c[:label => "3"]
  g.d[:label => "4"]
  g.e[:label => "5"]
  g.f[:label => "6"]

#   g.a << g.a
  g.a << g.b
  g.a << g.d
  (g.a << g.f)[:weight => 6, :label => "6"]
  g.b << g.c
  g.b << g.d
  g.b << g.e
  g.c << g.d
  (g.c << g.f)[:weight => 2, :label => "2"]
  g.d << g.e
#  g.e << g.c
end
g.output( :png => "matrix.png" )

t = GraphViz::Theory.new( g )

puts "Adjancy matrix : "
puts t.adjancy_matrix
# => [ 0 1 0 1 0 1]
#    [ 0 0 1 1 1 0]
#    [ 0 0 0 1 0 1]
#    [ 0 0 0 0 1 0]
#    [ 0 0 0 0 0 0]
#    [ 0 0 0 0 0 0]

puts "Symmetric ? #{t.symmetric?}"

puts "Incidence matrix :"
puts t.incidence_matrix
# => [  1  1  1  0  0  0  0  0  0]
#    [ -1  0  0  1  1  1  0  0  0]
#    [  0  0  0 -1  0  0  1  1  0]
#    [  0 -1  0  0 -1  0 -1  0  1]
#    [  0  0  0  0  0 -1  0  0 -1]
#    [  0  0 -1  0  0  0  0 -1  0]

g.each_node do |name, node|
  puts "Degree of node `#{name}' = #{t.degree(node)}"
  print "neighbors : "; p t.neighbors(name).map{ |e| e.id } # = node.neighbors.map { |e| e.id }
  print "incidents : "; p t.incidents(name).map{ |e| e.id } # = node.incidents.map { |e| e.id }
end

puts "Laplacian matrix :"
puts t.laplacian_matrix
# => [  3 -1  0 -1  0 -1]
#    [  0  4 -1 -1 -1  0]
#    [  0  0  3 -1  0 -1]
#    [  0  0  0  4 -1  0]
#    [  0  0  0  0  2  0]
#    [  0  0  0  0  0  2]

puts "Dijkstra between a and f"
r = t.moore_dijkstra(g.a, g.f)
if r.nil?
  puts "No way !"
else
  print "\tPath : "; p r[:path]
  puts "\tDistance : #{r[:distance]}"
end
# => Path : ["a", "b", "c", "f"]
#    Distance : 4.0

print "Ranges : "
rr = t.range
p rr
puts "Your graph contains circuits" if rr.include?(nil)

puts "Critical path : "
rrr = t.critical_path
print "\tPath "; p rrr[:path]
puts "\tDistance : #{rrr[:distance]}"

t.pagerank.each { |node, rank|
   puts "Pagerank for node #{node.id} = #{rank}"
}
