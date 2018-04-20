#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

{"png" => "#{$0}.png", "imap" => "#{$0}.html"}.each do |format, file|
  GraphViz::new( "G" ) { |g|
    g.command(:URL => "http://www.research.att.com/base.html")
    g._output(:label => "output", :URL => "colors.html")
    g.command << g._output
  }.output( format => file )
end