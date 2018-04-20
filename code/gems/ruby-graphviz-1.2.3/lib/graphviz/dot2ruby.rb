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

require 'graphviz/ext'
require 'graphviz/utils'

class Dot2Ruby #:nodoc:
  include GraphViz::Utils

  def initialize( xGVPath, xOutFile, xOutFormat = nil ) #:nodoc:
    paths = (xGVPath.nil?) ? [] : [xGVPath]
    @xGvprPath = find_executable( 'gvpr', paths )
    if(@xGvprPath.nil?)
      raise Exception, "GraphViz is not installed. Please be sure that 'gvpr' is on the search path'"
    end
    @xOutFile = xOutFile
    @xOutFormat = xOutFormat || "_"
    @gvprScript = GraphViz::Ext.find( "dot2ruby.g" )
  end

  def run( xFile ) #:nodoc:
    xCmd = [@xGvprPath, '-f', @gvprScript, '-a', @xOutFormat, xFile]
    xOutput = output_from_command( xCmd )
    if @xOutFile.nil?
      puts xOutput
    else
      File.open( @xOutFile, "w" ) do |io|
        io.print xOutput
      end
    end
  end

  def eval( xFile ) #:nodoc:
    xCmd = [@xGvprPath, '-f', @gvprScript, '-a', '-', xFile]
    xOutput = output_from_command( xCmd )
    instance_eval(xOutput)
    return @_graph_eval
  end

  def eval_string( data ) #:nodoc:
    t = Tempfile::open( File.basename(__FILE__) )
    t.print( data )
    t.close
    result = self.eval(t.path)
    t.close
    return result
  end
end
