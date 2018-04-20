$:.unshift("../lib")

require 'graphviz/dsl'
digraph :G do
   world[:label => "World"] << hello[:label => "Hello"]
   #world << hello

   output :png => "#{$0}.png"
end
