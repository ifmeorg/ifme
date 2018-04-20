class GraphViz
  class FamilyTree
    class Sibling
      def initialize( bns, parents )
        @brothers_and_sisters = bns
        @brothers_and_sisters.each do |person|
          person.sibling = self
        end
        @parents = parents
      end
    end
  end
end