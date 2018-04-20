# -*- coding: utf-8 -*-

require 'rubygems'
require 'graphviz'
require 'graphviz/family_tree/generation'
require 'graphviz/family_tree/person'
require 'graphviz/family_tree/couple'
require 'graphviz/family_tree/sibling'

class GraphViz
  class FamilyTree
    # Create a new family tree
    #
    #   require 'graphviz/family_tree'
    #   t = GraphViz::FamilyTree.new do
    #     ...
    #   end
    def initialize( &block )
      @persons = {}
      @graph = GraphViz.new( "FamilyTree", :use => :neato )
      @generation_number = 0
      @generations = []
      @couples = {}

      instance_eval(&block) if block
    end

    # Add a new generation in the tree
    #
    #   require 'graphviz/family_tree'
    #   t = GraphViz::FamilyTree.new do
    #     generation do
    #       ...
    #     end
    #     generation do
    #       ...
    #     end
    #   end
    def generation( &b )
      gen = GraphViz::FamilyTree::Generation.new( @graph, @persons, self, @generation_number )
      gen.make( &b )
      @generations << gen
      @generation_number += 1
    end

    def persons #:nodoc:
      @persons ||= {}
    end

    def add_couple( x, y, node ) #:nodoc:
      @couples[x] = {} if @couples[x].nil?
      @couples[x][y] = GraphViz::FamilyTree::Couple.new( @graph, node, [x, y] )
      @couples[y] = {} if @couples[y].nil?
      @couples[y][x] = @couples[x][y]
    end

    # Get a couple (GraphViz::FamilyTree::Couple)
    def couple( x, y )
      @couples[x][y]
    end

    def method_missing(sym, *args, &block) #:nodoc:
      persons[sym.to_s]
    end

    # Family size
    def size
      @persons.size
    end

    # Get the graph
    def graph
      maxY = @generations.size
      biggestGen, maxX = biggestGenerationNumberAndSize

      puts "#{maxY} generations"
      puts "Plus grosse generation : ##{biggestGen} avec #{maxX} personnes"

      puts "traitement des générations..."

      puts "  #{biggestGen}:"
      @generations[biggestGen].persons.each do |id, person|
        puts "    - #{id} : #{person.class}"
      end

      puts "  Up..."
      (0...biggestGen).reverse_each do |genNumber|
        puts "  #{genNumber}:"
        @generations[genNumber].persons.each do |id, person|
          puts "    - #{id} : #{person.class}"
        end
      end

      puts "  Down..."
      ((biggestGen+1)...maxY).each do |genNumber|
        puts "  #{genNumber}:"
        @generations[genNumber].persons.each do |id, person|
          puts "    - #{id} : #{person.class}"
        end
      end

      @graph
    end

    private
    def biggestGenerationNumberAndSize
      size = 0
      number = 0
      @generations.each do |gen|
        if gen.size > size
          size = gen.size
          number = gen.number
        end
      end
      return number, size
    end
  end
end
