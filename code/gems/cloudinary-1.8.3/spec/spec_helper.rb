require 'rspec'
require 'rexml/parsers/ultralightparser'
require 'rspec/version'
require 'rest_client'
require 'cloudinary'

Cloudinary.config.enhance_image_tag = true

TEST_IMAGE_URL = "http://cloudinary.com/images/old_logo.png"
TEST_IMG = "spec/logo.png"
TEST_IMG_W = 241
TEST_IMG_H = 51
SUFFIX = ENV['TRAVIS_JOB_ID'] || rand(999999999).to_s
TEST_TAG = 'cloudinary_gem_test'
TIMESTAMP_TAG = "#{TEST_TAG}_#{SUFFIX}_#{RUBY_VERSION}_#{ defined? Rails::version ? Rails::version : 'no_rails'}"

# Auth token
KEY     = "00112233FF99"
ALT_KEY = "CCBB2233FF00"


Dir[File.join(File.dirname(__FILE__), '/support/**/*.rb')].each {|f| require f}

module RSpec
  def self.project_root
    File.join(File.dirname(__FILE__), '..')
  end
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  unless RSpec::Version::STRING.match( /^3/)
    config.treat_symbols_as_metadata_keys_with_true_values = true
  end
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :delete_all => true
end

RSpec.shared_context "cleanup" do |tag|
  tag ||= TEST_TAG
  after :all do
    Cloudinary::Api.delete_resources_by_tag(tag) unless Cloudinary.config.keep_test_products
  end

end


CALLS_SERVER_WITH_PARAMETERS = "calls server with parameters"
RSpec.shared_examples CALLS_SERVER_WITH_PARAMETERS do |expected|
  expect(RestClient::Request).to receive(:execute).with(deep_hash_value(expected))
end

# Create a regexp with the given +tag+ name.
def html_tag_matcher( tag)
  /<#{tag}([\s]+([-[:word:]]+)[\s]*\=\s*\"([^\"]*)\")*\s*>.*<\s*\/#{tag}\s*>/
end

# Represents an HTML tag
class TestTag
  attr_accessor :name, :attributes, :children, :text, :html_string
  # Creates a new +TestTag+ from a given +element+ string
  def initialize(element)
    @html_string = element
    element = valid_tag(element) unless element.is_a? Array
    case element[0]
    when :start_element
      @name = element[2]
      @attributes = element[3]
      @children = (Array(element[4..-1]) || []).map {|c | TestTag.new c}
    when :text
      @text = element[1]
      @name = "text"
      @attributes = []
      @children = []
    end

  end

  # Parses a given +tag+ in string format
  def valid_tag(tag)
    parser = REXML::Parsers::UltraLightParser.new( tag)
    parser.parse[0]
  end

  # Returns attribute named +symbol_or_string+
  def [](symbol_or_string)
    attributes[symbol_or_string.to_s]
  end

  def method_missing(symbol, *args)
    if (m = /children_by_(\w+)/.match(symbol.to_s)) and !args.empty?
      @children.select{ |c| c[m[1]] == args[0]}
    else
      super
    end
  end

  def ==(other)
    case other
    when String
      @text == other
    else
      other.respond_to?( :text) &&
        other.respond_to?( :name) &&
        other.respond_to?( :attributes) &&
        other.respond_to?( :children) &&
        @text == other.text &&
        @name == other.name &&
        @attributes == other.attributes &&
        @children == other.children
    end
  end
end

RSpec::Matchers.define :produce_url do |expected_url|
  match do |params|
    public_id, options = params
    actual_options = options.clone
    @url = Cloudinary::Utils.cloudinary_url(public_id, actual_options)
    values_match? expected_url, @url
  end
  failure_message do |actual|
    "expected #{actual} to\nproduce: #{expected_url}\nbut got: #{@url}"
  end
end

RSpec::Matchers.define :mutate_options_to do |expected_options|
  match do |params|
    public_id, options = params
    options = options.clone
    Cloudinary::Utils.cloudinary_url(public_id, options)
    @actual = options
    values_match? expected_options, @actual
  end
end

RSpec::Matchers.define :empty_options do
  match do |params|
    public_id, options = params
    options = options.clone
    Cloudinary::Utils.cloudinary_url(public_id, options)
    options.empty?
  end
end

# Verify that the given URL can be served by Cloudinary by fetching the resource from the server
RSpec::Matchers.define :be_served_by_cloudinary do
  match do |url|
    if url.is_a? Array
      url, options = url
      url = Cloudinary::Utils.cloudinary_url(url, options.clone)
      if Cloudinary.config.upload_prefix
        res_prefix_uri = URI.parse(Cloudinary.config.upload_prefix)
        res_prefix_uri.path = '/res'
        url.gsub!(/https?:\/\/res.cloudinary.com/, res_prefix_uri.to_s)
      end
    end
    code = 0
    @url = url
    RestClient.get @url do |response, request, result|
      @result = result
      code = response.code
    end
    values_match? 200, code
  end

  failure_message do |actual|
    if @result
      "Couldn't serve #{actual}. #{@result["status"]}: #{@result["x-cld-error"]}"
    else
      "Couldn't serve #{actual}."
    end
  end
  failure_message_when_negated do |actual|
    if @result
      "Expected #{@url} not to be served by cloudinary. #{@result["status"]}: #{@result["x-cld-error"]}"
    else
      "Expected #{@url} not to be served by cloudinary."
    end

  end
end

def deep_fetch(hash, path)
  Array(path).reduce(hash) { |h, key| h && h.fetch(key, nil) }
end

# Matches deep values in the actual Hash, disregarding other keys and values.
# @example
#   expect( {:foo => { :bar => 'foobar'}}).to have_deep_hash_values_of( [:foo, :bar] => 'foobar')
#   expect( foo_instance).to receive(:bar_method).with(deep_hash_values_of([:foo, :bar] => 'foobar'))
RSpec::Matchers.define :deep_hash_value do |expected|
  match do |actual|
    expected.all? do |path, value|
      Cloudinary.values_match? value, deep_fetch(actual, path)
    end
  end
end

RSpec::Matchers.alias_matcher :have_deep_hash_values_of, :deep_hash_value

module Cloudinary
  # @api private
  def self.values_match?(expected, actual)
    if Hash === actual
      return hashes_match?(expected, actual) if Hash === expected
    elsif Array === expected && Enumerable === actual && !(Struct === actual)
      return arrays_match?(expected, actual.to_a)
    elsif Regexp === expected
      return expected.match actual.to_s
    end


    return true if actual == expected

    begin
      expected === actual
    rescue ArgumentError
      # Some objects, like 0-arg lambdas on 1.9+, raise
      # ArgumentError for `expected === actual`.
      false
    end
  end

  # @private
  def self.arrays_match?(expected_list, actual_list)
    return false if expected_list.size != actual_list.size

    expected_list.zip(actual_list).all? do |expected, actual|
      values_match?(expected, actual)
    end
  end

  # @private
  def self.hashes_match?(expected_hash, actual_hash)
    return false if expected_hash.size != actual_hash.size

    expected_hash.all? do |expected_key, expected_value|
      actual_value = actual_hash.fetch(expected_key) { return false }
      values_match?(expected_value, actual_value)
    end
  end

  private_class_method :arrays_match?, :hashes_match?
end