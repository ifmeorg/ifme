$:.unshift( "../lib" );
require 'graphviz/family_tree'

tree = GraphViz::FamilyTree.new do
  generation do
    abraham.is_a_man( "Abraham" )
    mona.is_a_woman( "Mona" )

    abraham.is_maried_with mona

    clancy.is_a_man( "Clancy" )
    jackeline.is_a_woman( "Jackeline" )

    clancy.is_maried_with jackeline
  end

  generation do
    herb.is_a_man( "Herb" )
    homer.is_a_man( "Homer" )

    marge.is_a_woman( "Marge" )
    patty.is_a_woman( "Patty" )
    selma.is_a_woman( "Selma" )

    homer.is_maried_with marge
  end

  couple( abraham, mona ).kids( herb, homer )
  couple( clancy, jackeline ).kids( marge, patty, selma )

  generation do
    bart.is_a_boy( "Bart" )
    lisa.is_a_girl( "Lisa" )
    maggie.is_a_girl( "Maggie" )
    ling.is_a_boy( "Ling" )
  end

  couple( homer, marge ).kids( bart, lisa, maggie )

  ling.kids( selma )
end

puts tree.graph.save( :none => String )
