require 'helper'

class TypesTest < Test::Unit::TestCase
  def setup
    @brown_txt = GraphViz::Utils::Colors.name("brown")
    @brown_hsv = GraphViz::Utils::Colors.hsv(0.0, 0.745454545454545, 0.647058823529412)
    @brown_rgb = GraphViz::Utils::Colors.rgb("a5", "2a", "2a")
  end

  def test_color
    assert @brown_txt
    assert @brown_hsv
    assert @brown_rgb
  end

  def test_color_by_name
    assert_equal "brown", @brown_txt.name
    assert_equal "brown", @brown_hsv.name
    assert_equal "brown", @brown_rgb.name
  end

  def test_color_by_rgb
    assert_equal "a5", @brown_txt.r
    assert_equal "2a", @brown_txt.g
    assert_equal "2a", @brown_txt.b
    assert_equal "#a52a2a", @brown_txt.rgba_string("#")

    assert_equal "a5", @brown_hsv.r
    assert_equal "2a", @brown_hsv.g
    assert_equal "2a", @brown_hsv.b
    assert_equal "#a52a2a", @brown_hsv.rgba_string("#")

    assert_equal "a5", @brown_rgb.r
    assert_equal "2a", @brown_rgb.g
    assert_equal "2a", @brown_rgb.b
    assert_equal "#a52a2a", @brown_rgb.rgba_string("#")
  end

  def test_color_by_hsv
    assert_equal @brown_rgb.h, @brown_txt.h
    assert_equal @brown_rgb.s, @brown_txt.s
    assert_equal @brown_rgb.v, @brown_txt.v

    assert_equal @brown_rgb.hsv_string, @brown_txt.hsv_string

    assert_equal 0.0.to_s, @brown_hsv.h.to_s
    assert_equal 0.745454545454545.to_s, @brown_hsv.s.to_s
    assert_equal 0.647058823529412.to_s, @brown_hsv.v.to_s

    assert_equal "0.0, 0.745454545454545, 0.647058823529412", @brown_hsv.hsv_string
  end
end
