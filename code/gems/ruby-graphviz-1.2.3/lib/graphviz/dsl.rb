require 'graphviz'

class GraphViz::DSL
   attr_accessor :graph

   # Create a new graph
   def initialize(name, options = {}, &block)
      @graph = GraphViz.new(name, options)
      instance_eval(&block) if block
   end

   def method_missing(sym, *args, &block) #:nodoc:
      return @graph.get_graph(sym.to_s) unless @graph.get_graph(sym.to_s).nil?
      return @graph.get_node(sym.to_s) unless @graph.get_node(sym.to_s).nil?
      if(@graph.respond_to?(sym, true))
         @graph.send(sym, *args)
      elsif(block)
         @graph.add_graph(GraphViz::DSL.new(sym, { :parent => @graph, :type => @graph.type }, &block).graph)
      else
         @graph.add_nodes(sym.to_s, *args)
      end
   end

   # Add a new node
   def n(name)
      return @graph.get_node(name) unless @graph.get_node(name.to_s).nil?
      @graph.add_nodes(name)
   end

   # Create edges
   def e(*args)
      e = nil
      last = args.shift
      while current = args.shift
         e = @graph.add_edges(last, current)
         last = current
      end
      return e
   end

   # Add a subgraph
   def subgraph(name, &block)
      @graph.add_graph(GraphViz::DSL.new(name, { :parent => @graph, :type => @graph.type }, &block).graph)
   end
   alias :cluster :subgraph

   # Generate output
   def output(options = {})
      @graph.output(options)
   end
end

# Create a new undirected graph
def graph(name, options = {}, &block)
   GraphViz::DSL.new(name, options.merge( { :type => "graph" } ), &block).graph
end

# Create a new directed graph
def digraph(name, options = {}, &block)
   GraphViz::DSL.new(name, options.merge( { :type => "digraph" } ), &block).graph
end

# Create a new strict directed graph
def strict(name, options = {}, &block)
   GraphViz::DSL.new(name, options.merge( { :type => "strict digraph" } ), &block).graph
end

