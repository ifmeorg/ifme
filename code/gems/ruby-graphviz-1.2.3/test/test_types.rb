require 'helper'

class TypesTest < Test::Unit::TestCase
  def test_gv_bool
    bool = nil

    assert_block "Create true GvBool failed." do
      bool = GraphViz::Types::GvBool.new(true)
    end
    assert bool
    assert_equal true, bool.to_ruby

    assert_block "Create \"true\" GvBool failed." do
      bool = GraphViz::Types::GvBool.new("true")
    end
    assert bool
    assert_equal true, bool.to_ruby

    assert_block "Create \"Yes\" GvBool failed." do
      bool = GraphViz::Types::GvBool.new("Yes")
    end
    assert bool
    assert_equal true, bool.to_ruby

    assert_block "Create 1 GvBool failed." do
      bool = GraphViz::Types::GvBool.new(1)
    end
    assert bool
    assert_equal true, bool.to_ruby

    assert_block "Create false GvBool failed." do
      bool = GraphViz::Types::GvBool.new(false)
    end
    assert bool
    assert_equal false, bool.to_ruby

    assert_block "Create \"false\" GvBool failed." do
      bool = GraphViz::Types::GvBool.new("false")
    end
    assert bool
    assert_equal false, bool.to_ruby

    assert_block "Create \"NO\" GvBool failed." do
      bool = GraphViz::Types::GvBool.new("NO")
    end
    assert bool
    assert_equal false, bool.to_ruby

    assert_block "Create 0 GvBool failed." do
      bool = GraphViz::Types::GvBool.new(0)
    end
    assert bool
    assert_equal false, bool.to_ruby

    assert_raise BoolException, "Wrong bool value" do
       GraphViz::Types::GvBool.new(:toto)
    end

    assert_block "Create GvBool with empty string failed." do
       bool = GraphViz::Types::GvBool.new("")
    end
    assert bool
    assert_equal false, bool.to_ruby
  end
end
