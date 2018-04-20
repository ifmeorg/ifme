require 'rubygems'
require 'bundler/setup'
require 'test/unit'
require 'pathname'

cur = Pathname.new(File.expand_path("..", __FILE__))
lib = cur.join('..', 'lib')

$LOAD_PATH.unshift(lib.to_s, cur.to_s)
require 'graphviz'
require 'graphviz/theory'
require 'graphviz/math/matrix'
require 'graphviz/utils/colors'
