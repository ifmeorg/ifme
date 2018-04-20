class GraphViz
  class FamilyTree
    class Generation
      def initialize( graph, persons, tree, gen_number ) #:nodoc:
        @graph = graph
        @all_persons = persons
        @persons = {}
        @tree = tree
        @gen_number = gen_number
      end

      def all_persons #:nodoc:
        @all_persons
      end

      def persons
        @persons
      end

      def make( &block ) #:nodoc:
        instance_eval(&block) if block
      end

      def method_missing(sym, *args, &block) #:nodoc:
        all_persons[sym.to_s] ||= (persons[sym.to_s] ||= GraphViz::FamilyTree::Person.new( @graph, @tree, self, sym.to_s ))
      end

      # Generation number
      def number
        @gen_number
      end

      # Generation size
      def size
        @persons.size
      end
    end
  end
end
