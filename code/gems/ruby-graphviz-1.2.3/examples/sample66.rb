$:.unshift("../lib")

require 'graphviz'
GraphViz.generate(30, 44, true, (1..8)).output(:png => "#{$0}.png")
