# This file use notugly.xsl: An XSL transform to pretty up the SVG output from Graphviz
#
# See: http://hokstad.com/making-graphviz-output-pretty-with-xsl
# And: http://hokstad.com/making-graphviz-output-pretty-with-xsl-updated
#
# By Vidar Hokstad and Ryan Shea; Contributions by Jonas Tingborn,
# Earl Cummings, Michael Kennedy (Graphviz 2.20.2 compatibility, bug fixes,
# testing, lots of gradients)

require 'rubygems'
begin
   require 'xml/xslt'
   XSLT_METHOD = :xml_xslt_transform
rescue LoadError => e
   require 'libxml'
   require 'libxslt'
   XSLT_METHOD = :libxslt_transform
end

class GraphViz
  # Transform to pretty up the SVG output
  #
  # For more information, see http://hokstad.com/making-graphviz-output-pretty-with-xsl
  # and http://hokstad.com/making-graphviz-output-pretty-with-xsl-updated
  #
  # You can use the :nothugly option to GraphViz#output :
  #
  #   graph.output( :svg => "myGraph.svg", :nothugly => true )
  #
  # Or directly on an SVG output graph :
  #
  #   GraphViz.nothugly( "myGraph.svg" )
  def self.nothugly( file, save = true )
    xsl = File.join( File.dirname(File.expand_path(__FILE__)), "nothugly", "nothugly.xsl" )
    out = self.send(XSLT_METHOD, file, xsl)

    if save
      fname = File.join( File.dirname(File.expand_path(file)), File.basename(file))
      File.open( fname, "w" ) { |io|
        io.print out
      }
    else
      return out
    end
  end

  def self.xml_xslt_transform(xml, xsl)
    xslt = XML::XSLT.new()
    xslt.xml = xml
    xslt.xsl = xsl
    xslt.serve()
  end

  def self.libxslt_transform(xml, xsl)
     LibXML::XML.default_load_external_dtd = false
     LibXML::XML.default_substitute_entities = false

     stylesheet_doc = LibXML::XML::Document.file(xsl)
     stylesheet = LibXSLT::XSLT::Stylesheet.new(stylesheet_doc)
     xml_doc = LibXML::XML::Document.file(xml)
     stylesheet.apply(xml_doc).to_s
  end
end
