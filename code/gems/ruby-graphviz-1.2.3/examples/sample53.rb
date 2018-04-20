$:.unshift( "../lib" )
require 'graphviz/family_tree'

tree = GraphViz::FamilyTree.new do
  generation do
    benoist.is_a_man( "Benoist" )
    nathalie.is_a_woman( "Nathalie" )

    benoist.is_maried_with nathalie
  end

  generation do
    charlotte.is_a_woman( "Charlotte" )
    amelie.is_a_woman( "Amelie" )
    clement.is_a_man( "Clement" )
    gregoire.is_a_man( "Gregoire" )

    muriel.is_a_woman( "Muriel" )

    gregoire.is_maried_with muriel
  end

  couple( benoist, nathalie ).kids( charlotte, amelie, clement, gregoire )
  end

tree.graph.save( :png => "#{$0}.png" )