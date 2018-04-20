#!/usr/bin/ruby

$:.unshift( "../../lib" );
require "graphviz"

Dir.glob( "*.dot" ) { |f|
  puts "#{f} : "
  begin
    puts GraphViz.parse(f)
  rescue SyntaxError => e
    puts "Error #{e.message}"
  end
}
