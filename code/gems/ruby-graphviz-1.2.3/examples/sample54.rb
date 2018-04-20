$:.unshift( "../lib" )
require 'graphviz'

class Array
  def rotate
    ## Solution #1 by greg
    # self.push(r = self.shift)
    # return r

    ## Solution #2 by madx
    # shift.tap {|e| push e }

    ## Solution #3 by greg
    push(shift)[-1]
  end
end

type = ["box", "point"]

GraphViz.graph( :G, :use => :neato ) { |g|
  (1..5).each do |x|
    (1..5).each do |y|
      g.add_nodes( "n#{x}x#{y}", :pos => "#{x},#{y}!", :shape => type.rotate )
    end
  end
}.output( :png => "#{$0}.png" )
