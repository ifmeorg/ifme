# Copyright (C) 2003 - 2012 Gregoire Lejeune <gregoire.lejeune@free.fr>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA


IS_JRUBY = (defined?( JRUBY_VERSION ) != nil)
IS_CYGWIN = ((RUBY_PLATFORM =~ /cygwin/) != nil)

require 'tempfile'

require 'graphviz/utils'
require 'graphviz/node'
require 'graphviz/edge'
require 'graphviz/attrs'
require 'graphviz/constants'
require 'graphviz/elements'
require 'graphviz/dot_script'

require 'graphviz/dot2ruby'
require 'graphviz/types'
require 'graphviz/core_ext'

if /^1.8/.match RUBY_VERSION
  $KCODE = "UTF8"
end

class GraphViz
  include GraphViz::Constants
  include GraphViz::Utils

  public

  ## Var: Output format (dot, png, jpeg, ...)
  @@format = nil #"canon"
  @format = nil
  ## Var: Output file name
  @filename = nil
  ## Var: Output format and file
  @output = nil
  ## Var: program to use (dot|twopi)
  @@prog = "dot"
  @prog = nil
  ## Var: program path
  @@path = []
  @path = nil
  ## Var: Error level
  @@errors = 1
  @errors = nil
  ## Var: External libraries
  @@extlibs = []
  @extlibs = nil

  ## Var: Graph name
  @name = nil

  ## Var: defined attributes
  @graph = nil
  @node = nil
  @edge = nil

  # This accessor allow you to set global graph attributes
  attr_accessor :graph
  alias_method :graph_attrs, :graph

  # This accessor allow you to set global nodes attributes
  attr_accessor :node
  alias_method :node_attrs, :node

  # This accessor allow you to set global edges attributes
  attr_accessor :edge
  alias_method :edge_attrs, :edge


  @elements_order = nil

  def add_node( xNodeName, hOpts = {} )
    if xNodeName.kind_of? Array
      raise ArgumentError, "use `add_nodes' to add several nodes at the same time"
    end
    return add_nodes(xNodeName, hOpts)
  end

  # Create a new node
  #
  # In:
  # * xNodeName : Name of the new node
  # * hOpts : Node attributes
  #
  # Return the GraphViz::Node object created
  def add_nodes(node_name, options = {})
     if node_name.kind_of? Array
        node_name.each { |n| add_nodes(n, options.clone) }
     else
        node = @hoNodes[node_name]

        if node.nil?
           @hoNodes[node_name] = GraphViz::Node::new( node_name, self )
           @hoNodes[node_name].index = @elements_order.size_of( "node" )

           unless options.keys.include?(:label) or options.keys.include?("label")
              options[:label] = node_name
           end

           @elements_order.push( {
              "type" => "node",
              "name" => node_name,
              "value" => @hoNodes[node_name]
           } )

           node = @hoNodes[node_name]
        end

        options.each do |xKey, xValue|
           @hoNodes[node_name][xKey.to_s] = xValue
        end

        return node
     end
  end

  # Return the node object for the given name (or nil) in the current graph
  def get_node( xNodeName, &block )
    node = @hoNodes[xNodeName] || nil

    yield( node ) if( block and node )

    return node
  end

  # Returns the first node found in the entire graph, starting from the root graph
  def find_node(name)
     root = root_graph
     return root.search_node(name)
  end

  # Return the first node found in the current graph, and it subgraphs
  def search_node(name)
     n = get_node(name)
     return n unless n.nil?
     each_graph { |_, g|
        n = g.search_node(name)
        return n unless n.nil?
     }
     return nil
  end

  #
  # Return the node object for the given index
  #
  def get_node_at_index( index )
    element = @elements_order[index, "node"]
    (element.nil?) ? nil : element["value"]
  end

  #
  # Allow you to traverse nodes
  #
  def each_node( &block )
    if block_given?
      @hoNodes.each do |name, node|
        yield( name, node )
      end
    else
      return( @hoNodes )
    end
  end

  # Get the number of nodes
  def node_count
    @hoNodes.size
  end

  def add_edge( oNodeOne, oNodeTwo, hOpts = {} )
    if oNodeTwo.kind_of? Array or oNodeOne.kind_of? Array 
      raise ArgumentError, "use `add_edges' to add several edges at the same time"
    end
    add_edges(oNodeOne, oNodeTwo, hOpts)
  end

  # Create a new edge
  #
  # In:
  # * node_one : First node (or node list)
  # * node_two : Second Node (or node list)
  # * options : Edge attributes
  def add_edges( node_one, node_two, options = {} )

    if( node_one.class == Array )
      node_one.each do |no|
        add_edges( no, node_two, options )
      end
    else
      if( node_two.class == Array )
        node_two.each do |nt|
          add_edges( node_one, nt, options )
        end
      else
        edge = GraphViz::Edge::new( node_one, node_two, self )
        edge.index = @elements_order.size_of( "edge" )

        options.each do |xKey, xValue|
          edge[xKey.to_s] = xValue
        end

        @elements_order.push( {
          "type" => "edge",
          "value" => edge
        } )
        @loEdges.push( edge )

        return( edge )
      end
    end
  end

  #
  # Allow you to traverse edges
  #
  def each_edge( &block )
    if block_given?
      @loEdges.each do |edge|
        yield(edge)
      end
    else
      return @loEdges
    end
  end

  #
  # Get the number of edges
  #
  def edge_count
    @loEdges.size
  end

  #
  # Return the edge object for the given index
  #
  def get_edge_at_index( index )
    element = @elements_order[index, "edge"]
    (element.nil?) ? nil : element["value"]
  end

  #
  # Create a new graph
  #
  # In:
  # * xGraphName : Graph name
  # * hOpts : Graph attributes
  #
  def add_graph( xGraphName = nil, hOpts = {}, &block )
     if xGraphName.kind_of?(GraphViz)
        xGraphID = xGraphName.id
        @hoGraphs[xGraphID] = xGraphName.clone
        @hoGraphs[xGraphID].type = @oGraphType
        @hoGraphs[xGraphID].pg = self
        xGraphName = xGraphID
     else
        if xGraphName.kind_of?(Hash)
           hOpts = xGraphName
           xGraphName = nil
        end

        if xGraphName.nil?
           xGraphID = String.random(11)
           xGraphName = ""
        else
           xGraphID = xGraphName
        end

        @hoGraphs[xGraphID] = GraphViz::new( xGraphName, {:parent => self, :type => @oGraphType}, &block )

        hOpts.each do |xKey, xValue|
           @hoGraphs[xGraphID][xKey.to_s] = xValue
        end
     end

     @elements_order.push( {
        "type" => "graph",
        "name" => xGraphName,
        "value" => @hoGraphs[xGraphID]
     } )

     return( @hoGraphs[xGraphID] )
  end
  alias :subgraph :add_graph
  #
  # Return the graph object for the given name (or nil)
  #
  def get_graph( xGraphName, &block )
    graph = @hoGraphs[xGraphName] || nil

    yield( graph ) if( block and graph )

    return graph
  end

  #
  # Allow you to traverse graphs
  #
  def each_graph( &block )
    if block_given?
      @hoGraphs.each do |name, graph|
        yield( name, graph )
      end
    else
      return @hoGraphs
    end
  end

  #
  # Add nodes and edges defined by a Hash
  #
  def add(h)
    if h.kind_of? Hash
      h.each do |node, data|
        add_hash_edge(node, data)
      end
    end
  end

  #
  # Return the graph type (graph digraph)
  #
  def type
    @oGraphType
  end
  def type=(x) #:nodoc:
    @oGraphType = x
  end

  #
  # Get the number of graphs
  #
  def graph_count
    @hoGraphs.size
  end

  def method_missing( idName, *args, &block ) #:nodoc:
    xName = idName.id2name

    rCod = nil

    if block
      # Creating a cluster named '#{xName}'
      rCod = add_graph( xName, args[0]||{} )
      yield( rCod )
    else
      # Create a node named '#{xName}' or search for a node, edge or cluster
      if @hoNodes.keys.include?( xName )
        if( args[0] )
          return { xName => args[0] }
        else
          return( @hoNodes[xName] )
        end
      end
      return( @hoGraphs[xName] ) if @hoGraphs.keys.include?( xName )

      rCod = add_nodes( xName, args[0]||{} )
    end

    return rCod
  end

  #
  # Set value +xValue+ to the graph attribute +xAttrName+
  #
  def []=( xAttrName, xValue )
    xValue = xValue.to_s if xValue.class == Symbol
    @graph[xAttrName] = xValue
  end

  #
  # Get the value of the graph attribute +xAttrName+
  #
  def []( xAttrName )
    if Hash === xAttrName
      xAttrName.each do |key, value|
        self[key] = value
      end
    else
      attr = @graph[xAttrName]
      if attr.nil?
        return nil
      else
        return( @graph[xAttrName].clone )
      end
    end
  end

  #
  # Calls block once for each attribute of the graph, passing the name and value to the
  # block as a two-element array.
  #
  def each_attribute(&b)
    @graph.each do |k,v|
      yield(k,v)
    end
  end
  def each_attribut(&b)
     warn "`GraphViz#each_attribut` is deprecated, please use `GraphViz#each_attribute`"
     each_attribute(&b)
  end

  # Create a new graph from the current subgraph
  def to_graph
    graph = self.clone
    graph.pg = nil
    return graph
  end

  #
  # Generate the graph
  #
  # Options :
  # * :output : Output format (GraphViz::Constants::FORMATS)
  # * :file : Output file name
  # * :use : Program to use (GraphViz::Constants::PROGRAMS)
  # * :path : Program PATH
  # * :<format> => <file> : <file> can be
  #   * a file name
  #   * nil, then the output will be printed to STDOUT
  #   * String, then the output will be returned as a String
  # * :errors : DOT error level (default 1)
  #   * 0 = Error + Warning
  #   * 1 = Error
  #   * 2 = none
  #
  def output( hOpts = {} )
    xDOTScript = DOTScript.new
    lNotHugly = []

    append_attributes_and_types(xDOTScript)

    xDOTScript << "}"

    if has_parent_graph?
      xDOTScript.make_subgraph("#{GraphViz.escape(@name, :unquote_empty => true)}")
    else
      hOutput = {}

      hOpts.each do |xKey, xValue|
        xValue = xValue.to_s unless xValue.nil? or [Class, TrueClass, FalseClass].include?(xValue.class)
        case xKey.to_s
          when "use"
            if PROGRAMS.index( xValue ).nil?
              raise ArgumentError, "can't use '#{xValue}'"
            end
            @prog = xValue
          when "path"
            @path = xValue && xValue.split( "," ).map{ |x| x.strip }
          when "errors"
            @errors = xValue
          when "extlib"
            @extlibs = xValue.split( "," ).map{ |x| x.strip }
          when "scale"
            # Scale input by 'v' (=72)
            @scale = xValue
          when "inverty"
            # Invert y coordinate in output
            @inverty = xValue
          when "no_layout"
            # No layout mode 'v' (=1)
            @no_layout = xValue
          when "reduce"
            # Reduce graph
            @reduce_graph = xValue
          when "Lg"
            # Don't use grid
            @Lg = xValue
          when "LO"
            # Use old attractive force
            @LO = xValue
          when "Ln"
            # Set number of iterations to i
            @Ln = xValue
          when "LU"
            # Set unscaled factor to i
            @LU = xValue
          when "LC"
            # Set overlap expansion factor to v
            @LC = xValue
          when "LT"
            # Set temperature (temperature factor) to v
            @LT = xValue
          when "nothugly"
            begin
              require 'graphviz/nothugly'
              @nothugly = true
            rescue LoadError
              warn "You must install ruby-xslt or libxslt-ruby to use nothugly option!"
              @nothugly = false
            end
          else
            if FORMATS.index( xKey.to_s ).nil?
              raise ArgumentError, "output format '#{xValue}' invalid"
            end
            hOutput[xKey.to_s] = xValue
        end
      end

      @output = hOutput if hOutput.size > 0

      xStict = ((@strict && @oGraphType == "digraph") ? "strict " : "")
      xDOTScript.prepend(
        "#{xStict}#{@oGraphType} #{GraphViz.escape(@name, :unquote_empty => true)} {"
      )

      xOutputString = (@filename == String ||
        @output.any? {|format, file| file == String })

      xOutput = ""
      if @format.to_s == "none" or @output.any? {|fmt, fn| fmt.to_s == "none"}
        if xOutputString
          xOutput << xDOTScript
        else
          xFileName = @output["none"] || @filename
          open( xFileName, "w" ) do |h|
            h.puts xDOTScript
          end
        end
      end

      if (@format.to_s != "none" and not @format.nil?) or (@output.any? {|format, file| format != "none" } and @output.size > 0)
        ## Act: Save script and send it to dot
        t = Tempfile::open( File.basename(__FILE__) )
        t.print( xDOTScript )
        t.close

        cmd = find_executable( @prog, @path )
        if cmd == nil
          raise StandardError, "GraphViz not installed or #{@prog} not in PATH. Install GraphViz or use the 'path' option"
        end

        xOutputWithFile = []
        xOutputWithoutFile = []
        unless @format.nil? or @format == "none"
          lNotHugly << @filename if @format.to_s == "svg" and @nothugly
          if @filename.nil? or @filename == String
            xOutputWithoutFile = ["-T#{@format}"]
          else
            xOutputWithFile = ["-T#{@format}", "-o#{@filename}"]
          end
        end
        @output.each_except( :key => ["none"] ) do |format, file|
          lNotHugly << file if format.to_s == "svg" and @nothugly
          if file.nil? or file == String
            xOutputWithoutFile += ["-T#{format}"]
          else
            xOutputWithFile += ["-T#{format}", "-o#{file}"]
          end
        end

        xExternalLibraries = @extlibs.map { |lib| "-l#{lib}" }

        xOtherOptions = []
        xOtherOptions << "-s#{@scale}" if @scale
        xOtherOptions << "-y" if @inverty
        xOtherOptions << "-n#{@no_layout}" if @no_layout
        xOtherOptions << "-x" if @reduce_graph
        xOtherOptions << "-Lg" if @Lg
        xOtherOptions << "-LO" if @LO
        xOtherOptions << "-Ln#{@Ln}" if @Ln
        xOtherOptions << "-LU#{@LU}" if @LU
        xOtherOptions << "-LC#{@LC}" if @LC
        xOtherOptions << "-LT#{@LT}" if @LT

        tmpPath = if IS_JRUBY
          t.path
        elsif IS_CYGWIN
          begin
            IO.popen("cygpath", "-w", t.path).chomp
          rescue
            warn "cygpath is not installed!"
            t.path
          end
        else
          t.path
        end

        xCmd = [cmd, "-q#{@errors}"] +
               xExternalLibraries +
               xOtherOptions +
               xOutputWithFile +
               xOutputWithoutFile +
               [tmpPath]

        xOutput << output_from_command( xCmd )
      end

      # Not Hugly
      lNotHugly.each do |f|
        if f.nil? or f == String
          xOutput = GraphViz.nothugly( xOutput, false )
        else
          GraphViz.nothugly( f, true )
        end
      end

      if xOutputString
        xOutput
      else
        print xOutput
      end
    end
  end
  alias :save :output

  def append_attributes_and_types(script)
    script_data = DOTScriptData.new

    @elements_order.each { |kElement|
      is_new_type = script_data.type != kElement["type"]
      if is_new_type 
        script << script_data unless script_data.type.nil? or script_data.empty?
        script_data = DOTScriptData.new(kElement["type"])
      end

      # Modified by Brandon Coleman verify value is NOT NULL
      kElement["value"] or raise ArgumentError, "#{kElement["name"]} is nil!"

      case kElement["type"]
        when "graph_attr", "node_attr", "edge_attr"
          script_data.add_attribute(kElement["name"], kElement["value"].to_gv)
        when "node", "graph"
          script << kElement["value"].output()
        when "edge"
          script << "  " + kElement["value"].output( @oGraphType )
        else
          raise ArgumentError,
            "Don't know what to do with element type '#{kElement['type']}'"
      end
    }
    script << script_data unless script_data.type.nil? or script_data.empty?
  end

  def to_s
    self.output(:none => String)
  end

  #
  # Get the graph name
  #
  def name
    @name.clone
  end
  alias :id :name

  #
  # Create an edge between the current cluster and the node or cluster +oNode+
  #
  def <<( oNode )
    raise( ArgumentError, "Edge between root graph and node or cluster not allowed!" ) if self.pg.nil?

    if( oNode.class == Array )
      oNode.each do |no|
        self << no
      end
    else
      return GraphViz::commonGraph( oNode, self ).add_edges( self, oNode )
    end
  end
  alias :> :<<
  alias :- :<<
  alias :>> :<<

  def pg #:nodoc:
    @oParentGraph
  end
  def pg=(x) #:nodoc:
    @oParentGraph = x
  end

  #
  # Return the root graph
  #
  def root_graph
    return( (self.pg.nil?) ? self : self.pg.root_graph )
  end

  def self.commonGraph( o1, o2 ) #:nodoc:
    g1 = o1.pg
    g2 = o2.pg

    return o1 if g1.nil?
    return o2 if g2.nil?

    return g1 if g1.object_id == g2.object_id

    return GraphViz::commonGraph( g1, g2 )
  end

  def set_position( xType, xKey, xValue ) #:nodoc:
    @elements_order.push( {
      "type" => "#{xType}_attr",
      "name" => xKey,
      "value" => xValue
    } )
  end

## ----------------------------------------------------------------------------

  #
  # Change default options (:use, :path, :errors and :output)
  #
  def self.default( hOpts )
    hOpts.each do |k, v|
      case k.to_s
        when "use"
          @@prog = v
        when "path"
          @@path = v.split( "," ).map{ |x| x.strip }
        when "errors"
          @@errors = v
        when "extlibs"
          @@extlibs = v.split( "," ).map{ |x| x.strip }
        else
          warn "Invalid option #{k}!"
      end
    end
  end

  def self.options( hOpts )
    GraphViz::default( hOpts )
  end

## ----------------------------------------------------------------------------

  # Create a new graph from a GraphViz File
  #
  # Options :
  # * :output : Output format (GraphViz::Constants::FORMATS) (default : dot)
  # * :file : Output file name (default : none)
  # * :use : Program to use (GraphViz::Constants::PROGRAMS) (default : dot)
  # * :path : Program PATH
  #
  def self.parse( xFile, hOpts = {}, &block )
    graph = Dot2Ruby::new( hOpts[:path], nil, nil ).eval( xFile )
    yield( graph ) if( block and graph )
    return graph
  end

  # Create a new graph from a GraphViz File
  #
  # Options :
  # * :output : Output format (GraphViz::Constants::FORMATS) (default : dot)
  # * :file : Output file name (default : none)
  # * :use : Program to use (GraphViz::Constants::PROGRAMS) (default : dot)
  # * :path : Program PATH
  #
  def self.parse_string( str, hOpts = {}, &block )
    graph = Dot2Ruby::new(hOpts[:path], nil, nil).eval_string(str)
    yield(graph) if(block and graph)
    return graph
  end

  # Return a new completed graph
  def complete
    GraphViz.parse_string( root_graph.output( :dot => String ) )
  end

  # Complete the current graph
  def complete!
    # TODO: Keep options
    complete
  end

  # Return true if the graph is directed.
  def directed?
    not((/digraph/ =~ "bla digraph bla").nil?)
  end

  def has_parent_graph?
     not @oParentGraph.nil?
  end
## ----------------------------------------------------------------------------

  private

  ## Var: Nodes, Edges and Graphs tables
  @hoNodes = nil
  @loEdges = nil
  @hoGraphs = nil

  ## Var: Parent graph
  @oParentGraph = nil

  ## Var: Type de graphe (orienté ou non)
  @oGraphType = nil

  #
  # Create a new graph object
  #
  # Options :
  # * :output : Output format (GraphViz::Constants::FORMATS) (default : dot)
  # * :file : Output file name (default : nil)
  # * :use : Program to use (GraphViz::Constants::PROGRAMS) (default : dot)
  # * :path : Program PATH
  # * :parent : Parent graph (default : nil)
  # * :type : Graph type (GraphViz::Constants::GRAPHTYPE) (default : digraph)
  # * :errors : DOT error level (default 1)
  #   * 0 = Error + Warning
  #   * 1 = Error
  #   * 2 = none
  #
  def initialize( xGraphName, hOpts = {}, &block )
    @filename = nil
    @name     = xGraphName.to_s
    @format   = @@format
    @prog     = @@prog
    @path     = @@path
    @errors   = @@errors
    @extlibs  = @@extlibs
    @output   = {}
    @nothugly = false
    @strict   = false

    @scale        = nil
    @inverty      = nil
    @no_layout    = nil
    @reduce_graph = nil
    @Lg           = nil
    @LO           = nil
    @Ln           = nil
    @LU           = nil
    @LC           = nil
    @LT           = nil

    @elements_order = GraphViz::Elements::new()

    @oParentGraph = nil
    @oGraphType   = "digraph"

    @hoNodes  = Hash::new()
    @loEdges  = Array::new()
    @hoGraphs = Hash::new()

    @node  = GraphViz::Attrs::new( self, "node",  NODESATTRS  )
    @edge  = GraphViz::Attrs::new( self, "edge",  EDGESATTRS  )
    @graph = GraphViz::Attrs::new( self, "graph", GRAPHSATTRS )

    hOpts.each do |xKey, xValue|
      case xKey.to_s
        when "use"
          if PROGRAMS.index( xValue.to_s ).nil?
            raise ArgumentError, "can't use '#{xValue}'"
          end
          @prog = xValue.to_s
        when "parent"
          @oParentGraph = xValue
        when "type"
          if GRAPHTYPE.index( xValue.to_s ).nil?
            raise ArgumentError, "graph type '#{xValue}' unknow"
          end
          @oGraphType = xValue.to_s
        when "path"
          @path = xValue.split( "," ).map{ |x| x.strip }
        when "strict"
          @strict = (xValue ? true : false)
        when "errors"
          @errors = xValue
        when "extlibs"
          @extlibs = xValue.split( "," ).map{ |x| x.strip }
        else
          self[xKey.to_s] = xValue.to_s
      end
    end

    yield( self ) if( block )
  end

  # Edge between a node and a Hash
  # Used by GraphViz#add
  def add_hash_edge(node, hash)
    if hash.kind_of? Hash
      hash.each do |nt, data|
        add_edges(node, nt)
        add_hash_edge(nt, data)
      end
    else
      add_edges(node, hash)
    end
  end

  #
  # Create a new undirected graph
  #
  # See also GraphViz::new
  #
  def self.graph( xGraphName, hOpts = {}, &block )
    new( xGraphName, hOpts.symbolize_keys.merge( {:type => "graph"} ), &block )
  end

  #
  # Create a new directed graph
  #
  # See also GraphViz::new
  #
  def self.digraph( xGraphName, hOpts = {}, &block )
    new( xGraphName, hOpts.symbolize_keys.merge( {:type => "digraph"} ), &block )
  end

  # Create a new strict directed graph
  #
  # See also GraphViz::new
  def self.strict_digraph( xGraphName, hOpts = {}, &block )
    new( xGraphName, hOpts.symbolize_keys.merge( {:type => "digraph", :strict => true} ), &block )
  end

  # Create a random graph.
  def self.generate(num_nodes, num_edges, directed = false, weight_range = (1..1))
     g = nil
     if directed
        g = GraphViz.digraph(:G)
     else
        g = GraphViz.graph(:G)
     end

     nodes = (1..num_nodes).map{ |e| e.to_s }
     g.add_nodes(nodes)

     edges = []
     nodes.each do |head|
        nodes.each do |tail|
           if (directed and head != tail) or (head < tail)
              edges << {:head => head, :tail => tail, :weight => weight_range.to_a.shuffle[0]}
           end
        end
     end
     edges.shuffle!

     (num_edges - 1).times do |i|
        g.add_edges(edges[i][:head], edges[i][:tail], :label => edges[i][:weight].to_s, :weight => edges[i][:weight])
     end

     return g
  end

  #
  # Escape a string to be acceptable as a node name in a graphviz input file
  #
  def self.escape(str, opts = {} ) #:nodoc:
    options = {
      :force => false,
      :unquote_empty => false,
    }.merge(opts)

    reserved_words = %w{node edge graph digraph subgraph strict}
    if (options[:force] or str.match( /\A[a-zA-Z_]+[a-zA-Z0-9_]*\Z/ ).nil? or reserved_words.include?(str.downcase))
      unless options[:unquote_empty] and str.size == 0
        '"' + str.gsub('"', '\\"').gsub("\n", '\\\\n') + '"'
      end
    else
      str
    end
  end
end
