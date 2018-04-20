require 'helper'

class GraphVizDOTScriptTest < Test::Unit::TestCase
  def setup
    @script = GraphViz::DOTScript.new
  end

  def test_appends_a_newline_character_if_it_is_missing
    str = "Test without newline"
    @script.append(str)
    assert_equal @script.to_s, str + "\n"
  end

  def test_does_not_append_a_newline_if_already_present
    str = "Linebreak follows at my tail:\n"
    @script.append(str)
    assert_equal @script.to_s, str
  end

  def test_can_prepend_lines_to_its_content
    start_content = "I want to be at the top!\n"
    additional_content = "No way!\n"

    @script.append(start_content)
    @script.prepend(additional_content)

    assert_equal @script.to_s, additional_content + start_content
  end

  def test_can_add_types_with_data
    data = "some random data"
    @script.add_type("node_attr", data)
    assert_match(/\s*node\s*\[\s*#{data}\s*\]\s*/, @script.to_s)
  end

  def test_does_nothing_if_data_is_empty
    @script.add_type("anything", "")
    assert_equal true, @script.to_s.empty?
  end

  def test_raises_an_argument_error_on_unknown_types
    assert_raise ArgumentError do
      @script.add_type("invalid", "some data")
    end
  end
end

