# frozen_string_literal: true
# encoding: UTF-8

module RSpecHtmlMatchers

  # @api
  # @private
  class NokogiriTextHelper
    NON_BREAKING_SPACE = "\u00a0"

    def initialize text, squeeze_text = false
      @text = text
      @squeeze_text = squeeze_text
    end

    def content node_set
      node_set.find_all do |node|
        actual_content = node.content.gsub(NON_BREAKING_SPACE, ' ')
        actual_content = node.content.strip.squeeze(' ') if @squeeze_text

        actual_content == @text
      end
    end
  end

end