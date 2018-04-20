# frozen_string_literal: true
# encoding: UTF-8

module RSpecHtmlMatchers

  # @api
  # @private
  # for nokogiri regexp matching
  class NokogiriRegexpHelper
    def initialize(regex)
      @regex = regex
    end

    def regexp node_set
      node_set.find_all { |node| node.content =~ @regex }
    end
  end

end