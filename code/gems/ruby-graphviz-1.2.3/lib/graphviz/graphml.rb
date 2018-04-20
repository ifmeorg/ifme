#!/usr/bin/env ruby
# Copyright (C) 2010 Gregoire Lejeune <gregoire.lejeune@free.fr>
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

require 'graphviz'
require 'rexml/document'

class GraphViz
  class GraphMLError < RuntimeError
  end

  class GraphML
    attr_reader :attributes
    def attributs
       warn "`GraphViz::GraphML#attributs` is deprecated, please, use `GraphViz::GraphML#attributes`"
       return @attributes
    end

    # The GraphViz object
    attr_accessor :graph

    DEST = {
      'node'      => [:nodes],
      'edge'      => [:edges],
      'graph'     => [:graphs],
      'graphml'   => [:graphml],
      'hyperedge' => [:hyperedge],
      'port'      => [:port],
      'endpoint'  => [:endpoint],
      'all'       => [:nodes, :edges, :graphs, :graphml, :hyperedge, :port, :endpoint]
    }

    GTYPE = {
      'directed' => :digraph,
      'undirected' => :graph
    }

    # Create a new GraphViz object from a GraphML file of string
    def initialize( file_or_str )
      data = ((File.file?( file_or_str )) ? File::new(file_or_str) : file_or_str)
      @xmlDoc = REXML::Document::new( data )
      @attributes = {
        :nodes => {},
        :edges => {},
        :graphs => {},
        :graphml => {},
        :endpoint => {},
        :port => {},
        :hyperedge => {}
      }
      @ignored_keys = []
      @graph = nil
      @current_attr = nil
      @current_node = nil
      @current_edge = nil
      @current_graph = nil

      parse( @xmlDoc.root )
    end

    def parse( node ) #:nodoc:
      send( node.name.to_sym, node )
    end

    def graphml( node ) #:nodoc:
      node.each_element( ) do |child|
        begin
          send( "graphml_#{child.name}".to_sym, child )
        rescue NoMethodError => e
          raise GraphMLError, "node #{child.name} can be child of graphml"
        end
      end
    end

    def graphml_data(node)
       warn "graphml/data not supported!"
    end

    def graphml_key( node ) #:nodoc:
      id = node.attributes['id']
      @current_attr = {
        :name => node.attributes['attr.name'],
        :type => node.attributes['attr.type']
      }
      if @current_attr[:name].nil?
        @ignored_keys << id
      else
        DEST[node.attributes['for']].each do |d|
          @attributes[d][id] = @current_attr
        end

        node.each_element( ) do |child|
          begin
            send( "graphml_key_#{child.name}".to_sym, child )
          rescue NoMethodError => e
            raise GraphMLError, "node #{child.name} can be child of key"
          end
        end
      end

      @current_attr = nil
    end

    def graphml_key_default( node ) #:nodoc:
      @current_attr[:default] = node.texts().join('\n')
    end

    def graphml_graph( node ) #:nodoc:
      @current_node = nil

      if @current_graph.nil?
        @graph = GraphViz.new( node.attributes['id'], :type => GTYPE[node.attributes['edgedefault']] )
        @current_graph = @graph
        previous_graph = @graph
      else
        previous_graph = @current_graph
        @current_graph = previous_graph.add_graph( node.attributes['id'] )
      end

      @attributes[:graphs].each do |id, data|
        begin
          @current_graph.graph[data[:name]] = data[:default] if data.has_key?(:default)
        rescue ArgumentError => e
          warn e
        end
      end
      @attributes[:nodes].each do |id, data|
        begin
          @current_graph.node[data[:name]] = data[:default] if data.has_key?(:default)
        rescue ArgumentError => e
          warn e
        end
      end
      @attributes[:edges].each do |id, data|
        begin
          @current_graph.edge[data[:name]] = data[:default] if data.has_key?(:default)
        rescue ArgumentError => e
          warn e
        end
      end

      node.each_element( ) do |child|
        send( "graphml_graph_#{child.name}".to_sym, child )
      end

      @current_graph = previous_graph
    end

    def graphml_graph_data( node ) #:nodoc:
      begin
        @current_graph[@attributes[:graphs][node.attributes['key']][:name]] = node.texts().join('\n')
      rescue ArgumentError => e
        warn e
      end
    end

    def graphml_graph_node( node ) #:nodoc:
      @current_node = {}

      node.each_element( ) do |child|
        case child.name
        when "graph"
          graphml_graph( child )
        else
          begin
            send( "graphml_graph_node_#{child.name}".to_sym, child )
          rescue NoMethodError => e
            raise GraphMLError, "node #{child.name} can be child of node"
          end
        end
      end

      unless @current_node.nil?
        node = @current_graph.add_nodes( node.attributes['id'] )
        @current_node.each do |k, v|
          begin
            node[k] = v
          rescue ArgumentError => e
            warn e
          end
        end
      end

      @current_node = nil
    end

    def graphml_graph_node_data( node ) #:nodoc:
      return if @ignored_keys.include?(node.attributes['key'])
      begin
        @current_node[@attributes[:nodes][node.attributes['key']][:name]] = node.texts().join('\n')
      rescue ArgumentError => e
        warn e
      end
    end

    def graphml_graph_node_port( node ) #:nodoc:
      @current_node[:shape] = :record
      port = node.attributes['name']
      if @current_node[:label]
        label = @current_node[:label].gsub( "{", "" ).gsub( "}", "" )
        @current_node[:label] = "#{label}|<#{port}> #{port}"
      else
        @current_node[:label] = "<#{port}> #{port}"
      end
    end

    def graphml_graph_edge( node ) #:nodoc:
      source = node.attributes['source']
      source = {source => node.attributes['sourceport']} if node.attributes['sourceport']
      target = node.attributes['target']
      target = {target => node.attributes['targetport']} if node.attributes['targetport']

      @current_edge = @current_graph.add_edges( source, target )

      node.each_element( ) do |child|
        begin
          send( "graphml_graph_edge_#{child.name}".to_sym, child )
        rescue NoMethodError => e
          raise GraphMLError, "node #{child.name} can be child of edge"
        end
      end

      @current_edge = nil
    end

    def graphml_graph_edge_data( node ) #:nodoc:
      return if @ignored_keys.include?(node.attributes['key'])
      begin
        @current_edge[@attributes[:edges][node.attributes['key']][:name]] = node.texts().join('\n')
      rescue ArgumentError => e
        warn e
      end
    end

    def graphml_graph_hyperedge( node ) #:nodoc:
      list = []

      node.each_element( ) do |child|
        if child.name == "endpoint"
          if child.attributes['port']
            list << { child.attributes['node'] => child.attributes['port'] }
          else
            list << child.attributes['node']
          end
        end
      end

      list.each { |s|
        list.each { |t|
          @current_graph.add_edges( s, t ) unless s == t
        }
      }
    end
  end
end
