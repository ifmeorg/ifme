# frozen_string_literal: true
# encoding: UTF-8

require 'rspec'
require 'nokogiri'

require 'rspec-html-matchers/nokogiri_regexp_helper'
require 'rspec-html-matchers/nokogiri_text_helper'
require 'rspec-html-matchers/have_tag'

module RSpecHtmlMatchers

  # tag assertion, this is the core of functionality, other matchers are shortcuts to this matcher
  #
  # @yield block where you should put with_tag, without_tag and/or other matchers
  #
  # @param [String] tag     css selector for tag you want to match, e.g. 'div', 'section#my', 'article.red'
  # @param [Hash]   options options hash(see below)
  # @option options [Hash]   :with  hash with html attributes, within this, *:class* option have special meaning, you may specify it as array of expected classes or string of classes separated by spaces, order does not matter
  # @option options [Fixnum] :count for tag count matching(*ATTENTION:* do not use :count with :minimum(:min) or :maximum(:max))
  # @option options [Range]  :count not strict tag count matching, count of tags should be in specified range
  # @option options [Fixnum] :minimum minimum count of elements to match
  # @option options [Fixnum] :min same as :minimum
  # @option options [Fixnum] :maximum maximum count of elements to match
  # @option options [Fixnum] :max same as :maximum
  # @option options [String/Regexp] :text to match tag content, could be either String or Regexp
  #
  # @example
  #   expect(rendered).to have_tag('div')
  #   expect(rendered).to have_tag('h1.header')
  #   expect(rendered).to have_tag('div#footer')
  #   expect(rendered).to have_tag('input#email', :with => { :name => 'user[email]', :type => 'email' } )
  #   expect(rendered).to have_tag('div', :count => 3)            # matches exactly 3 'div' tags
  #   expect(rendered).to have_tag('div', :count => 3..7)         # shortcut for have_tag('div', :minimum => 3, :maximum => 7)
  #   expect(rendered).to have_tag('div', :minimum => 3)          # matches more(or equal) than 3 'div' tags
  #   expect(rendered).to have_tag('div', :maximum => 3)          # matches less(or equal) than 3 'div' tags
  #   expect(rendered).to have_tag('p', :text => 'some content')  # will match "<p>some content</p>"
  #   expect(rendered).to have_tag('p', :text => /some content/i) # will match "<p>sOme cOntEnt</p>"
  #   expect(rendered).to have_tag('textarea', :with => {:name => 'user[description]'}, :text => "I like pie")
  #   expect("<html>
  #     <body>
  #       <h1>some html document</h1>
  #     </body>
  #    </html>").to have_tag('body') { with_tag('h1', :text => 'some html document') }
  #   expect('<div class="one two">').to have_tag('div', :with => { :class => ['two', 'one'] })
  #   expect('<div class="one two">').to have_tag('div', :with => { :class => 'two one' })
  def have_tag tag, options={}, &block
    # for backwards compatibility with rpecs have tag:
    options = { :text => options } if options.kind_of?(String) || options.kind_of?(Regexp)
    @__current_scope_for_nokogiri_matcher = HaveTag.new(tag, options, &block)
  end

  def have_empty_tag tag, options={}
    have_tag(tag, options.merge(:text => ""))
  end

  def with_text text
    raise StandardError, 'this matcher should be used inside "have_tag" matcher block' unless defined?(@__current_scope_for_nokogiri_matcher)
    raise ArgumentError, 'this matcher does not accept block' if block_given?
    tag = @__current_scope_for_nokogiri_matcher.instance_variable_get(:@tag)
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag(tag, :text => text)
    end
  end

  def without_text text
    raise StandardError, 'this matcher should be used inside "have_tag" matcher block' unless defined?(@__current_scope_for_nokogiri_matcher)
    raise ArgumentError, 'this matcher does not accept block' if block_given?
    tag = @__current_scope_for_nokogiri_matcher.instance_variable_get(:@tag)
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag(tag, :text => text)
    end
  end
  alias :but_without_text :without_text

  # with_tag matcher
  # @yield block where you should put other with_tag or without_tag
  # @see #have_tag
  # @note this should be used within block of have_tag matcher
  def with_tag tag, options={}, &block
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag(tag, options, &block)
    end
  end

  # without_tag matcher
  # @yield block where you should put other with_tag or without_tag
  # @see #have_tag
  # @note this should be used within block of have_tag matcher
  def without_tag tag, options={}, &block
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag(tag, options, &block)
    end
  end

  # form assertion
  #
  # it is a shortcut to
  #   have_tag 'form', :with => { :action => action_url, :method => method ... }
  # @yield block with with_<field>, see below
  # @see #have_tag
  def have_form action_url, method, options={}, &block
    options[:with] ||= {}
    id = options[:with].delete(:id)
    tag = 'form'; tag += '#'+id if id
    options[:with].merge!(:action => action_url)
    options[:with].merge!(:method => method.to_s)
    have_tag tag, options, &block
  end

  #@TODO fix code duplications

  def with_hidden_field name, value=nil
    options = form_tag_options('hidden',name,value)
    should_have_input(options)
  end

  def without_hidden_field name, value=nil
    options = form_tag_options('hidden',name,value)
    should_not_have_input(options)
  end

  def with_text_field name, value=nil
    options = form_tag_options('text',name,value)
    should_have_input(options)
  end

  def without_text_field name, value=nil
    options = form_tag_options('text',name,value)
    should_not_have_input(options)
  end

  def with_email_field name, value=nil
    options = form_tag_options('email',name,value)
    should_have_input(options)
  end

  def without_email_field name, value=nil
    options = form_tag_options('email',name,value)
    should_not_have_input(options)
  end

  def with_url_field name, value=nil
    options = form_tag_options('url',name,value)
    should_have_input(options)
  end

  def without_url_field name, value=nil
    options = form_tag_options('url',name,value)
    should_not_have_input(options)
  end

  def with_number_field name, value=nil
    options = form_tag_options('number',name,value)
    should_have_input(options)
  end

  def without_number_field name, value=nil
    options = form_tag_options('number',name,value)
    should_not_have_input(options)
  end

  def with_range_field name, min, max, options={}
    options = { :with => { :name => name, :type => 'range', :min => min.to_s, :max => max.to_s }.merge(options.delete(:with)||{}) }
    should_have_input(options)
  end

  def without_range_field name, min=nil, max=nil, options={}
    options = { :with => { :name => name, :type => 'range' }.merge(options.delete(:with)||{}) }
    options[:with].merge!(:min => min.to_s) if min
    options[:with].merge!(:max => max.to_s) if max
    should_not_have_input(options)
  end

  DATE_FIELD_TYPES = %w( date month week time datetime datetime-local )

  def with_date_field date_field_type, name=nil, options={}
    date_field_type = date_field_type.to_s
    raise "unknown type `#{date_field_type}` for date picker" unless DATE_FIELD_TYPES.include?(date_field_type)
    options = { :with => { :type => date_field_type.to_s }.merge(options.delete(:with)||{}) }
    options[:with].merge!(:name => name.to_s) if name
    should_have_input(options)
  end

  def without_date_field date_field_type, name=nil, options={}
    date_field_type = date_field_type.to_s
    raise "unknown type `#{date_field_type}` for date picker" unless DATE_FIELD_TYPES.include?(date_field_type)
    options = { :with => { :type => date_field_type.to_s }.merge(options.delete(:with)||{}) }
    options[:with].merge!(:name => name.to_s) if name
    should_not_have_input(options)
  end

  def with_password_field name, value=nil
    # TODO add ability to explicitly say that value should be empty
    options = form_tag_options('password',name,value)
    should_have_input(options)
  end

  def without_password_field name, value=nil
    options = form_tag_options('password',name,value)
    should_not_have_input(options)
  end

  def with_file_field name, value=nil
    options = form_tag_options('file',name,value)
    should_have_input(options)
  end

  def without_file_field name, value=nil
    options = form_tag_options('file',name,value)
    should_not_have_input(options)
  end

  def with_text_area name
    # TODO, should be: with_text_area name, text=nil
    #options = form_tag_options('text',name,value)
    options = { :with => { :name => name } }
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag('textarea', options)
    end
  end

  def without_text_area name
    # TODO, should be: without_text_area name, text=nil
    #options = form_tag_options('text',name,value)
    options = { :with => { :name => name } }
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag('textarea', options)
    end
  end

  def with_checkbox name, value=nil
    options = form_tag_options('checkbox',name,value)
    should_have_input(options)
  end

  def without_checkbox name, value=nil
    options = form_tag_options('checkbox',name,value)
    should_not_have_input(options)
  end

  def with_radio_button name, value
    options = form_tag_options('radio',name,value)
    should_have_input(options)
  end

  def without_radio_button name, value
    options = form_tag_options('radio',name,value)
    should_not_have_input(options)
  end

  def with_select name, options={}, &block
    options[:with] ||= {}
    id = options[:with].delete(:id)
    tag='select'; tag += '#'+id if id
    options[:with].merge!(:name => name)
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag(tag, options, &block)
    end
  end

  def without_select name, options={}, &block
    options[:with] ||= {}
    id = options[:with].delete(:id)
    tag='select'; tag += '#'+id if id
    options[:with].merge!(:name => name)
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag(tag, options, &block)
    end
  end

  def with_option text, value=nil, options={}
    options[:with] ||= {}
    if value.is_a?(Hash)
      options.merge!(value)
      value=nil
    end
    tag='option'
    options[:with].merge!(:value => value.to_s) if value
    if options[:selected]
      options[:with].merge!(:selected => "selected")
    end
    options.delete(:selected)
    options.merge!(:text => text) if text
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag(tag, options)
    end
  end

  def without_option text, value=nil, options={}
    options[:with] ||= {}
    if value.is_a?(Hash)
      options.merge!(value)
      value=nil
    end
    tag='option'
    options[:with].merge!(:value => value.to_s) if value
    if options[:selected]
      options[:with].merge!(:selected => "selected")
    end
    options.delete(:selected)
    options.merge!(:text => text) if text
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag(tag, options)
    end
  end

  def with_button text, value=nil, options={}
    options[:with] ||= {}
    if value.is_a?(Hash)
      options.merge!(value)
      value=nil
    end
    options[:with].merge!(:value => value.to_s) if value
    options.merge!(:text => text) if text
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag('button', options)
    end
  end

  def without_button text, value=nil, options={}
    options[:with] ||= {}
    if value.is_a?(Hash)
      options.merge!(value)
      value=nil
    end
    options[:with].merge!(:value => value.to_s) if value
    options.merge!(:text => text) if text
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag('button', options)
    end
  end

  def with_submit value
    options = { :with => { :type => 'submit', :value => value } }
    #options = form_tag_options('text',name,value)
    should_have_input(options)
  end

  def without_submit value
    #options = form_tag_options('text',name,value)
    options = { :with => { :type => 'submit', :value => value } }
    should_not_have_input(options)
  end

  private

  def should_have_input(options)
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to have_tag('input', options)
    end
  end

  def should_not_have_input(options)
    within_nested_tag do
      expect(@__current_scope_for_nokogiri_matcher).to_not have_tag('input', options)
    end
  end

  # form_tag in method name name mean smth. like input, submit, tags that should appear in a form
  def form_tag_options form_tag_type, form_tag_name, form_tag_value=nil
    options = { :with => { :name => form_tag_name, :type => form_tag_type } }
    # .to_s if value is a digit or smth. else, see issue#10
    options[:with].merge!(:value => form_tag_value.to_s) if form_tag_value
    return options
  end

  def within_nested_tag(&block)
    raise 'block needed' unless block_given?
    parent_scope = @__current_scope_for_nokogiri_matcher
    block.call
    @__current_scope_for_nokogiri_matcher = parent_scope
  end

end
