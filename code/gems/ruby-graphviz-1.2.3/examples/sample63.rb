$:.unshift( "../lib" )
require 'graphviz/dsl'

digraph :G do
   cluster_0 do
      graph[:style => :filled, :color => :lightgrey]
      node[:style => :filled, :color => :white]
      a0 << a1 << a2 << a3
      graph[:label => "process #1"]
   end

   cluster_1 do
      node[:style => :filled]
      b0 << b1 << b2 << b3
      graph[:label => "process #2", :color => :blue]
   end

   start << a0
   start << b0
   a1 << b3
   b2 << a3
   a3 << a0
   a3 << _end
   b3 << _end

   start[:shape] = :Mdiamond
   _end[:label] = "end"
   _end[:shape] = :Mdiamond

   output(:png => "#{$0}.png")
end

