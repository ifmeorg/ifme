require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

module CustomDotMatchers
  class HaveDotOptions
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      return false unless @target =~ /\[(.*)\]/
      @options = Regexp.last_match(1)
      @options == @expected
    end

    def failure_message
      "expected '#{@target.strip}' to have options '[#{@expected}]'"
    end

    def negative_failure_message
      "expected '#{@target.strip}' to not have options '[#{@expected}]'"
    end

    def description
      'have dot options'
    end
  end
  def have_dot_options(expected)
    HaveDotOptions.new expected
  end
end

describe DiagramGraph do
  include CustomDotMatchers

  before do
    @diagram_graph = DiagramGraph.new
  end

  # describe ".dot_edge" do
  #   context "has_a/belongs_to" do
  #     it { @diagram_graph.send(:dot_edge, "one-one", "source", "target").must_include "arrowtail=odot, arrowhead=dot, dir=both" }
  #   end

  #   context "has_many/belongs_to" do
  #     it { @diagram_graph.send(:dot_edge, "one-many", "source", "target").must_include "arrowtail=odot, arrowhead=crow, dir=both" }
  #   end

  #   context "habtm" do
  #     it { @diagram_graph.send(:dot_edge, "many-many", "source", "target").must_include "arrowtail=crow, arrowhead=crow, dir=both" }
  #   end
  # end
end
