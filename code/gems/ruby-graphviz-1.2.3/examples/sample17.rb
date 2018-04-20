#!/usr/bin/ruby

$:.unshift( "../lib" );
require "graphviz"

GraphViz::new( "G", :type => "graph", :rankdir => "LR", :bgcolor => "#808080" ) { |graph|
  graph.edge[:dir] = "none"

  graph.node[:width] = "0.3"
  graph.node[:height] = "0.3"
  graph.node[:label] = ""

  _ = {}

  ("1".."8").each do |v|
    _[v] = graph.add_nodes( v, :shape => "circle", :style => "invis")
  end
  ["10","20","30","40","50","60","70","80"].each do |v|
    _[v] = graph.add_nodes( v, :shape => "circle", :style => "invis")
  end

  ("a".."x").each do |v|
    _[v] = graph.add_nodes( v, :shape => "circle")
  end

  ("A".."X").each do |v|
    _[v] = graph.add_nodes( v, :shape => "diamond")
  end

  (_["1"] << _["a"])[:color]="#0000ff"
  (_["a"] << _["A"])[:color]="#0000ff"
  (_["a"] << _["B"])[:color]="#0000ff"
  (_["2"] << _["b"])[:color]="#ff0000"
  (_["b"] << _["B"])[:color]="#ff0000"
  (_["b"] << _["A"])[:color]="#ff0000"
  (_["3"] << _["c"])[:color]="#ffff00"
  (_["c"] << _["C"])[:color]="#ffff00"
  (_["c"] << _["D"])[:color]="#ffff00"
  (_["4"] << _["d"])[:color]="#00ff00"
  (_["d"] << _["D"])[:color]="#00ff00"
  (_["d"] << _["C"])[:color]="#00ff00"
  (_["5"] << _["e"])[:color]="#000000"
  (_["e"] << _["E"])[:color]="#000000"
  (_["e"] << _["F"])[:color]="#000000"
  (_["6"] << _["f"])[:color]="#00ffff"
  (_["f"] << _["F"])[:color]="#00ffff"
  (_["f"] << _["E"])[:color]="#00ffff"
  (_["7"] << _["g"])[:color]="#ffffff"
  (_["g"] << _["G"])[:color]="#ffffff"
  (_["g"] << _["H"])[:color]="#ffffff"
  (_["8"] << _["h"])[:color]="#ff00ff"
  (_["h"] << _["H"])[:color]="#ff00ff"
  (_["h"] << _["G"])[:color]="#ff00ff"

  graph.edge[:color]="#ff0000:#0000ff"
  _["A"] << _["i"]; _["i"] << [_["I"], _["K"]]
  _["B"] << _["j"]; _["j"] << [_["J"], _["L"]]

  graph.edge[:color]="#00ff00:#ffff00"
  _["C"] << _["k"]; _["k"] << [_["K"], _["I"]]
  _["D"] << _["l"]; _["l"] << [_["L"], _["J"]]

  graph.edge[:color]="#00ffff:#000000"
  _["E"] << _["m"]; _["m"] << [_["M"], _["O"]]
  _["F"] << _["n"]; _["n"] << [_["N"], _["P"]]

  graph.edge[:color]="#ff00ff:#ffffff"
  _["G"] << _["o"]; _["o"] << [_["O"], _["M"]]
  _["H"] << _["p"]; _["p"] << [_["P"], _["N"]]

  graph.edge[:color]="#00ff00:#ffff00:#ff0000:#0000ff"
  _["I"] << _["q"]; _["q"] << [_["Q"], _["U"]]
  _["J"] << _["r"]; _["r"] << [_["R"], _["V"]]
  _["K"] << _["s"]; _["s"] << [_["S"], _["W"]]
  _["L"] << _["t"]; _["t"] << [_["T"], _["X"]]

  graph.edge[:color]="#ff00ff:#ffffff:#00ffff:#000000"
  _["M"] << _["u"]; _["u"] << [_["U"], _["Q"]]
  _["N"] << _["v"]; _["v"] << [_["V"], _["R"]]
  _["O"] << _["w"]; _["w"] << [_["W"], _["S"]]
  _["P"] << _["x"]; _["x"] << [_["X"], _["T"]]

	graph.edge[:color]="#ff00ff:#ffffff:#00ffff:#000000:#00ff00:#ffff00:#ff0000:#0000ff"
	_["Q"] << _["10"]
	_["R"] << _["20"]
	_["S"] << _["30"]
	_["T"] << _["40"]
	_["U"] << _["50"]
	_["V"] << _["60"]
	_["W"] << _["70"]
	_["X"] << _["80"]
}.output( :path => '/usr/local/bin/', :png => "#{$0}.png" )
