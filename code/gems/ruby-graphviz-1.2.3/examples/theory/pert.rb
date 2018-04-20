$:.unshift( "../../lib" )
require 'graphviz'
require 'graphviz/theory'

g = GraphViz.digraph( "G", :path => "/usr/local/bin", :use => "fdp" ) do |g|
  g.node[:shape => "record"]

  g.start[:label => "Start"]
  g.task_1[:label => "Task #1 - Duration : 4d"]
  g.task_2[:label => "Task #2 - Duration : 5.25d"]
  g.task_3[:label => "Task #3 - Duration : 5.17d"]
  g.task_4[:label => "Task #4 - Duration : 6.33d"]
  g.task_5[:label => "Task #5 - Duration : 5.17d"]
  g.task_6[:label => "Task #6 - Duration : 4.5d"]
  g.task_7[:label => "Task #7 - Duration : 5.17d"]
  g.finish[:label => "End"]

  (g.start << g.task_1)[:weight => 0.0]
  (g.start << g.task_2)[:weight => 0.0]
  (g.task_1 << g.task_3)[:weight => 4.0]
  (g.task_1 << g.task_4)[:weight => 4.0]
  (g.task_2 << g.task_5)[:weight => 5.25]
  (g.task_3 << g.task_5)[:weight => 5.17]
  (g.task_4 << g.task_6)[:weight => 6.33]
  (g.task_5 << g.task_7)[:weight => 5.17]
  (g.task_6 << g.finish)[:weight => 4.5]
  (g.task_7 << g.finish)[:weight => 5.17]
end
g.output( :png => "PERT.png" )

t = GraphViz::Theory.new( g )

print "Ranges : "
rr = t.range
p rr
puts "Your graph contains circuits" if rr.include?(nil)

puts "Critical path : "
rrr = t.critical_path
print "\tPath :"
_ = ""
rrr[:path].each do |i|
  print _ + g.get_node_at_index(i-1).id
  _ = " -> "
end
puts
puts "\tDistance : #{rrr[:distance]}"