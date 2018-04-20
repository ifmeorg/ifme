# Copyright (C) 2004 - 2012 Gregoire Lejeune <gregoire.lejeune@free.fr>
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

# Constants for ruby-graphviz
#
# GraphViz::Constants::FORMATS: the possible output formats
#   "bmp", "canon", "dot", "xdot", "cmap", "dia", "eps",
#   "fig", "gd", "gd2", "gif", "gtk", "hpgl", "ico", "imap",
#   "cmapx", "imap_np", "cmapx_np", "ismap", "jpeg", "jpg",
#   "jpe", "mif", "mp", "pcl", "pdf", "pic", "plain",
#   "plain-ext", "png", "ps", "ps2", "svg", "svgz", "tga",
#   "tiff", "tif", "vml", "vmlz", "vrml", "vtx", "wbmp",
#   "xlib", "none"
#
# GraphViz::Constants::PROGRAMS: The possible programs
#   "dot", "neato", "twopi", "fdp", "circo"
#
# GraphViz::Constants::GRAPHTYPE The possible types of graph
#   "digraph", "graph"
#
#
# The single letter codes used in constructors map as follows:
#   G => The root graph, with GRAPHATTRS
#   E => Edge, with EDGESATTRS
#   N => Node, with NODESATTRS
#   S => subgraph
#   C => cluster
#
class GraphViz
  module Constants
    RGV_VERSION = "1.2.3"

    ## Const: Output formats
    FORMATS = [
      "bmp",
      "canon",
      "dot",
      "xdot",
      "cmap",
      "dia",
      "eps",
      "fig",
      "gd",
      "gd2",
      "gif",
      "gtk",
      "hpgl",
      "ico",
      "imap",
      "cmapx",
      "imap_np",
      "cmapx_np",
      "ismap",
      "jpeg",
      "jpg",
      "jpe",
      "mif",
      "mp",
      "pcl",
      "pdf",
      "pic",
      "plain",
      "plain-ext",
      "png",
      "ps",
      "ps2",
      "svg",
      "svgz",
      "tga",
      "tiff",
      "tif",
      "vml",
      "vmlz",
      "vrml",
      "vtx",
      "wbmp",
      "xlib",
      "none"
    ]

    ## Const: programs
    PROGRAMS = [
      "dot",
      "neato",
      "twopi",
      "fdp",
      "circo",
      "sfdp"
    ]

    ## Const: graphs type
    GRAPHTYPE = [
      "digraph",
      "graph",
      "strict digraph"
    ]

    def self.getAttrsFor( x )
      list = {}
      GENCS_ATTRS.each { |k,v|
        list[k] = v[:type] if x.match( v[:usedBy] ) and not list.keys.include?(k)
      }
      list
    end

    # E, N, G, S and C represent edges, nodes, the root graph, subgraphs and cluster subgraphs, respectively
    GENCS_ATTRS = {
      "Damping"             => { :usedBy => "G",    :type => :GvDouble },
      "K"                   => { :usedBy => "GC",   :type => :GvDouble },
      "URL"                 => { :usedBy => "ENGC", :type => :EscString },
      "_background"         => { :usedBy => "G",    :type => :EscString },
      "area"                => { :usedBy => "NC",   :type => :GvDouble },
      "arrowhead"           => { :usedBy => "E",    :type => :ArrowType }, # arrowType
      "arrowsize"           => { :usedBy => "E",    :type => :GvDouble },
      "arrowtail"           => { :usedBy => "E",    :type => :ArrowType }, # arrowType
      #"aspect"              => { :usedBy => "G",    :type => :EscString }, # aspectType
      "bb"                  => { :usedBy => "G",    :type => :Rect }, # rect
      "bgcolor"             => { :usedBy => "GC",   :type => :Color }, # color
      "center"              => { :usedBy => "G",    :type => :GvBool },    # bool
      "charset"             => { :usedBy => "G",    :type => :EscString }, # string
      "clusterrank"         => { :usedBy => "G",    :type => :EscString }, # clusterMode
      "color"               => { :usedBy => "ENC",  :type => :ColorList }, # color, colorList
      "colorscheme"         => { :usedBy => "ENCG", :type => :EscString }, # string
      "comment"             => { :usedBy => "ENG",  :type => :EscString }, # string
      "compound"            => { :usedBy => "G",    :type => :GvBool },    # bool
      "concentrate"         => { :usedBy => "G",    :type => :GvBool },    # bool
      "constraint"          => { :usedBy => "E",    :type => :GvBool },    # bool
      "decorate"            => { :usedBy => "E",    :type => :GvBool },    # bool
      "defaultdist"         => { :usedBy => "G",    :type => :GvDouble },
      "dim"                 => { :usedBy => "G",    :type => :EscString }, # int
      "dimen"               => { :usedBy => "G",    :type => :EscString }, # int
      "dir"                 => { :usedBy => "E",    :type => :EscString }, # dirType
      "diredgeconstraints"  => { :usedBy => "G",    :type => :EscString }, # string, bool
      "distortion"          => { :usedBy => "N",    :type => :GvDouble },
      "dpi"                 => { :usedBy => "G",    :type => :GvDouble },
      "edgeURL"             => { :usedBy => "E",    :type => :EscString },
      "edgehref"            => { :usedBy => "E",    :type => :EscString },
      "edgetarget"          => { :usedBy => "E",    :type => :EscString },
      "edgetooltip"         => { :usedBy => "E",    :type => :EscString },
      "epsilon"             => { :usedBy => "G",    :type => :GvDouble },
      "esep"                => { :usedBy => "G",    :type => :EscString }, # GvDouble , pointf
      "fillcolor"           => { :usedBy => "NEC",  :type => :Color }, # color
      "fixedsize"           => { :usedBy => "N",    :type => :GvBool }, # bool
      "fontcolor"           => { :usedBy => "ENGC", :type => :Color }, # color
      "fontname"            => { :usedBy => "ENGC", :type => :EscString }, # string
      "fontnames"           => { :usedBy => "G",    :type => :EscString }, # string
      "fontpath"            => { :usedBy => "G",    :type => :EscString }, # string
      "fontsize"            => { :usedBy => "ENGC", :type => :GvDouble },
      "forcelabels"         => { :usedBy => "G",    :type => :GvBool}, # bool
      "gradientangle"       => { :usedBy => "NCG",  :type => :EscString }, # int
      "group"               => { :usedBy => "N",    :type => :EscString }, # string
      "headURL"             => { :usedBy => "E",    :type => :EscString },
      "head_lp"             => { :usedBy => "E",    :type => :EscString }, #point
      "headclip"            => { :usedBy => "E",    :type => :GvBool }, # bool
      "headhref"            => { :usedBy => "E",    :type => :EscString },
      "headlabel"           => { :usedBy => "E",    :type => :EscString }, # LblString
      "headport"            => { :usedBy => "E",    :type => :EscString }, # portPos
      "headtarget"          => { :usedBy => "E",    :type => :EscString },
      "headtooltip"         => { :usedBy => "E",    :type => :EscString },
      "height"              => { :usedBy => "N",    :type => :GvDouble },
      "href"                => { :usedBy => "ENGC", :type => :EscString },
      "id"                  => { :usedBy => "ENG",  :type => :EscString },
      "image"               => { :usedBy => "N",    :type => :EscString }, # string
      "imagepath"           => { :usedBy => "G",    :type => :EscString }, # string
      "imagescale"          => { :usedBy => "N",    :type => :EscString }, # bool, string
      "inputscale"          => { :usedBy => "G",    :type => :GvDouble },
      "label"               => { :usedBy => "ENGC", :type => :LblString },
      "labelURL"            => { :usedBy => "E",    :type => :EscString },
      "label_scheme"        => { :usedBy => "G",    :type => :EscString }, # int
      "labelangle"          => { :usedBy => "E",    :type => :GvDouble },
      "labeldistance"       => { :usedBy => "E",    :type => :GvDouble },
      "labelfloat"          => { :usedBy => "E",    :type => :GvBool }, # bool
      "labelfontcolor"      => { :usedBy => "E",    :type => :Color }, # color
      "labelfontname"       => { :usedBy => "E",    :type => :EscString }, # string
      "labelfontsize"       => { :usedBy => "E",    :type => :GvDouble },
      "labelhref"           => { :usedBy => "E",    :type => :EscString },
      "labeljust"           => { :usedBy => "GC",   :type => :EscString }, # string
      "labelloc"            => { :usedBy => "GCN",  :type => :EscString }, # string
      "labeltarget"         => { :usedBy => "E",    :type => :EscString },
      "labeltooltip"        => { :usedBy => "E",    :type => :EscString },
      "landscape"           => { :usedBy => "G",    :type => :GvBool }, # bool
      "layer"               => { :usedBy => "ENC",  :type => :EscString }, # layerRange
      "layerlistsep"        => { :usedBy => "G",    :type => :EscString }, # string
      "layers"              => { :usedBy => "G",    :type => :EscString }, # layerList
      "layerselect"         => { :usedBy => "G",    :type => :EscString }, # layerRange
      "layersep"            => { :usedBy => "G",    :type => :EscString }, # string
      "layout"              => { :usedBy => "G",    :type => :EscString }, # string
      "len"                 => { :usedBy => "E",    :type => :GvDouble },
      "levels"              => { :usedBy => "G",    :type => :EscString }, # int
      "levelsgap"           => { :usedBy => "G",    :type => :GvDouble },
      "lhead"               => { :usedBy => "E",    :type => :EscString }, # string
      "lheight"             => { :usedBy => "GC",   :type => :GvDouble },
      "lp"                  => { :usedBy => "EGC",  :type => :EscString }, # point
      "ltail"               => { :usedBy => "E",    :type => :EscString }, # string
      "lwidth"              => { :usedBy => "GC",   :type => :GvDouble },
      "margin"              => { :usedBy => "NGC",  :type => :EscString }, # GvDouble , pointf
      "maxiter"             => { :usedBy => "G",    :type => :EscString }, # int
      "mclimit"             => { :usedBy => "G",    :type => :GvDouble },
      "mindist"             => { :usedBy => "G",    :type => :GvDouble },
      "minlen"              => { :usedBy => "E",    :type => :EscString }, # int
      "mode"                => { :usedBy => "G",    :type => :EscString }, # string
      "model"               => { :usedBy => "G",    :type => :EscString }, # string
      "mosek"               => { :usedBy => "G",    :type => :GvBool }, # bool
      "nodesep"             => { :usedBy => "G",    :type => :GvDouble },
      "nojustify"           => { :usedBy => "GCNE", :type => :GvBool }, # bool
      "normalize"           => { :usedBy => "G",    :type => :GvBool }, # bool
      "nslimit"             => { :usedBy => "G",    :type => :GvDouble },
      "nslimit1"            => { :usedBy => "G",    :type => :GvDouble },
      "ordering"            => { :usedBy => "GN",   :type => :EscString }, # string
      "orientation"         => { :usedBy => "NG",   :type => :GvDouble },  # N: double, G: string
      "outputorder"         => { :usedBy => "G",    :type => :EscString }, # outputMode
      "overlap"             => { :usedBy => "G",    :type => :EscString }, # string, bool
      "overlap_scaling"     => { :usedBy => "G",    :type => :GvDouble },
      "overlap_shrink"      => { :usedBy => "G",    :type => :GvBool },
      "pack"                => { :usedBy => "G",    :type => :EscString }, # bool, int
      "packmode"            => { :usedBy => "G",    :type => :EscString }, # packMode
      "pad"                 => { :usedBy => "G",    :type => :EscString }, # GvDouble , pointf
      "page"                => { :usedBy => "G",    :type => :EscString }, # GvDouble , pointf
      "pagedir"             => { :usedBy => "G",    :type => :EscString }, # pageDir
      "pencolor"            => { :usedBy => "C",    :type => :Color }, # color
      "penwidth"            => { :usedBy => "CNE",  :type => :GvDouble },
      "peripheries"         => { :usedBy => "NC",   :type => :EscString }, # int
      "pin"                 => { :usedBy => "N",    :type => :GvBool }, # bool
      "pos"                 => { :usedBy => "EN",   :type => :SplineType }, # point, splineTypes
      "quadtree"            => { :usedBy => "G",    :type => :GvBool }, # bool
      "quantum"             => { :usedBy => "G",    :type => :GvDouble },
      "rank"                => { :usedBy => "S",    :type => :EscString }, # rankType
      "rankdir"             => { :usedBy => "G",    :type => :EscString }, # rankDir
      "ranksep"             => { :usedBy => "G",    :type => :EscString }, # GvDouble, doubleList
      "ratio"               => { :usedBy => "G",    :type => :EscString }, # GvDouble, String
      "rects"               => { :usedBy => "N",    :type => :Rect }, # rect
      "regular"             => { :usedBy => "N",    :type => :GvBool }, # bool
      "remincross"          => { :usedBy => "G",    :type => :GvBool }, # bool
      "repulsiveforce"      => { :usedBy => "G",    :type => :GvDouble },
      "resolution"          => { :usedBy => "G",    :type => :GvDouble },
      "root"                => { :usedBy => "GN",   :type => :EscString }, # bool, string
      "rotate"              => { :usedBy => "G",    :type => :EscString }, # int
      "rotation"            => { :usedBy => "G",    :type => :GvDouble },
      "samehead"            => { :usedBy => "E",    :type => :EscString }, # string
      "sametail"            => { :usedBy => "E",    :type => :EscString }, # string
      "samplepoints"        => { :usedBy => "G",    :type => :EscString }, # int
      "scale"               => { :usedBy => "G",    :type => :EscString }, # double, pointf
      "searchsize"          => { :usedBy => "G",    :type => :EscString }, # int
      "sep"                 => { :usedBy => "G",    :type => :EscString }, # double , pointf
      "shape"               => { :usedBy => "N",    :type => :EscString }, # shape
      "shapefile"           => { :usedBy => "N",    :type => :EscString }, # string
      "showboxes"           => { :usedBy => "ENG",  :type => :EscString }, # int
      "sides"               => { :usedBy => "N",    :type => :EscString }, # int
      "size"                => { :usedBy => "NG",   :type => :EscString }, # double , pointf
      "skew"                => { :usedBy => "N",    :type => :GvDouble },
      "smoothing"           => { :usedBy => "G",    :type => :EscString }, # smoothType
      "sortv"               => { :usedBy => "GCN",  :type => :EscString }, # int
      "splines"             => { :usedBy => "G",    :type => :EscString }, # bool, string
      "start"               => { :usedBy => "G",    :type => :EscString }, # startType
      "style"               => { :usedBy => "ENCG", :type => :EscString }, # style
      "stylesheet"          => { :usedBy => "G",    :type => :EscString }, # string
      "tailURL"             => { :usedBy => "E",    :type => :EscString },
      "tail_lp"             => { :usedBy => "E",    :type => :EscString }, #point
      "tailclip"            => { :usedBy => "E",    :type => :GvBool }, # bool
      "tailhref"            => { :usedBy => "E",    :type => :EscString },
      "taillabel"           => { :usedBy => "E",    :type => :EscString }, # lblString
      "tailport"            => { :usedBy => "E",    :type => :EscString }, # portPos
      "tailtarget"          => { :usedBy => "E",    :type => :EscString },
      "tailtooltip"         => { :usedBy => "E",    :type => :EscString },
      "target"              => { :usedBy => "ENGC", :type => :EscString }, # escString, string
      "tooltip"             => { :usedBy => "NEC",  :type => :EscString },
      "truecolor"           => { :usedBy => "G",    :type => :GvBool }, # bool
      "vertices"            => { :usedBy => "N",    :type => :EscString }, # pointfList
      "viewport"            => { :usedBy => "G",    :type => :EscString }, # viewPort
      "voro_margin"         => { :usedBy => "G",    :type => :GvDouble },
      "weight"              => { :usedBy => "E",    :type => :GvDouble },
      "width"               => { :usedBy => "N",    :type => :GvDouble },
      "xdotversion"         => { :usedBy => "G",    :type => :EscString },
      "xlabel"              => { :usedBy => "EN",   :type => :LblString },
      "xlp"                 => { :usedBy => "EN",   :type => :EscString }, # point
      "z"                   => { :usedBy => "N",    :type => :GvDouble }
    }

    ## Const: Graph attributes
    GRAPHSATTRS = GraphViz::Constants::getAttrsFor( /G|S|C/ )

    ## Const: Node attributes
    NODESATTRS = GraphViz::Constants::getAttrsFor( /N/ )

    ## Const: Edge attributes
    EDGESATTRS = GraphViz::Constants::getAttrsFor( /E/ )
  end
end
