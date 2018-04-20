$:.unshift( "../lib" );
require "graphviz"

g = GraphViz::new( "structs" )

g.node["shape"] = "plaintext"

g.add_nodes( "HTML" )

g.add_nodes( "struct1", "label" => '<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">
  <TR>
    <TD>left</TD>
    <TD PORT="f1">mid dle</TD>
    <TD PORT="f2">right</TD>
  </TR>
</TABLE>>' )

g.add_nodes( "struct2", "label" => '<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0">  <TR><TD PORT="f0">one</TD><TD>two</TD></TR> </TABLE>>' )
g.add_nodes( "struct3", "label" => '<<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">  <TR>  <TD ROWSPAN="3">hello<BR/>world</TD>  <TD COLSPAN="3">b</TD>  <TD ROWSPAN="3">g</TD>  <TD ROWSPAN="3">h</TD>  </TR>  <TR>  <TD>c</TD><TD PORT="here">d</TD><TD>e</TD>  </TR>  <TR>  <TD COLSPAN="3">f</TD>  </TR> </TABLE>>' )

g.add_edges( {"struct1" => :f1}, {"struct2" => :f0} )
g.add_edges( {"struct1" => :f2}, {"struct3" => :here} )

g.add_edges( "HTML", "struct1" )

g.output( :path => ARGV[0], :png => "#{$0}.png" )
