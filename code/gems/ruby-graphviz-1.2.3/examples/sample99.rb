$:.unshift( "../lib" );
require 'graphviz/family_tree'

tree = GraphViz::FamilyTree.new do
  generation do
    chantale.is_a_woman( "Chantale" )
    jacques.is_a_man( "Jacques" )

    jacques.is_dead
    jacques.is_maried_with chantale

    rose.is_a_woman( "Rose Marie" )
    andre.is_a_man( "Andre" )

    andre.is_maried_with rose
    andre.is_dead
  end

  generation do
    benoist.is_a_man( "Benoist" )
    nathalie.is_a_woman( "Nathalie" )

    benoist.is_maried_with nathalie

    michel.is_a_man( "Michel" )
    brigitte.is_a_woman( "Brigitte" )

    michel.is_maried_with brigitte
  end

  couple( chantale, jacques ).kids( nathalie )
  couple( rose, andre ).kids( benoist )

  generation do
    charlotte.is_a_woman( "Charlotte" )
    amelie.is_a_woman( "Amelie" )
    clement.is_a_man( "Clement" )
    gregoire.is_a_man( "Gregoire" )

    muriel.is_a_woman( "Muriel" )
    gilles.is_a_man( "Gilles" )

    morgane.is_a_woman( "Morgane" )
    gregoire.is_divorced_with morgane

    pascal.is_a_man( "Pascal" )
    muriel.is_divorced_with pascal

    gregoire.is_maried_with muriel
  end

  couple( michel, brigitte ).kids( muriel, gilles )
  couple( benoist, nathalie ).kids( charlotte, amelie, clement, gregoire )

  generation do
    arthur.is_a_boy( "Arthur" )
    colyne.is_a_girl( "Colyne" )
    benedict.is_a_boy( "Benedict" )
    maia.is_a_girl( "Maia" )
    enaitz.is_a_boy( "Enaitz" )
    milo.is_a_boy( "Milo" )
  end

  couple( gregoire, morgane ).kids( arthur, colyne, benedict )
  couple( gregoire, muriel ).kids( maia )
  couple( muriel, pascal ).kids( milo )
  muriel.kids( enaitz )
end

tree.graph.save( :png => "#{$0}.png" )
