$:.unshift "../lib:lib"
require 'test/unit'
require 'choice'
require 'choice/option'

class TestOption < Test::Unit::TestCase
  def setup
    Choice.reset!
    @option = Choice::Option.new
  end
  
  def test_desc
    line_one = "This is a description."
    line_two = "I can add many lines."
    line_three = "There is no limit."
    
    assert_equal false, @option.desc?
    
    @option.desc line_one
    @option.desc line_two
    
    assert @option.desc?    
    assert_equal [line_one, line_two], @option.desc
    
    @option.desc line_three
    assert @option.desc?    
    assert_equal [line_one, line_two, line_three], @option.desc
  end
  
  def test_choice
    short = "-p"
    
    assert_equal false, @option.short?
    
    @option.short short
    
    assert @option.short?
    assert_equal short, @option.short
  end
  
  def test_no_choice
    default = 42
    
    assert_raise(Choice::Option::ParseError) do
      @option.defaut?
    end
    
    assert_raise(Choice::Option::ParseError) do
      @option.defaut default
    end    
    
    assert_raise(Choice::Option::ParseError) do
      @option.defaut
    end    

  end
  
  def test_block_choice
    assert_equal false, @option.action?

    @option.action do 
      1 + 1
    end

    assert @option.action?
    assert_block(&@option.action)
  end
  
  def test_format
    @option = Choice::Option.new do
      validate /^\w+$/
    end
    
    assert_equal /^\w+$/, @option.validate

    block = proc { |f| File.exists? f }
    @option = Choice::Option.new do
      validate &block
    end

    assert_equal block, @option.validate
  end  
  
  def test_dsl
    @option = Choice::Option.new do
      short "-h"
      long "--host=HOST"
      cast String
      desc "The hostname."
      desc "(Alphanumeric only)"
      filter do
        5 * 10
      end
    end

    assert_equal "-h", @option.short
    assert_equal "--host=HOST", @option.long
    assert_equal String, @option.cast
    assert_equal ["The hostname.", "(Alphanumeric only)"], @option.desc
    assert_equal proc { 5 * 10 }.call, @option.filter.call
  end
  
  def test_to_a
    desc = "This is your description."
    short = "-t"
    long = "--test=METHOD"
    default = :to_a
    
    @option.desc desc
    @option.short short
    @option.long long
    @option.default default
    @option.action { 1 + 1 }
    array = @option.to_a
        
    assert_equal Choice::Option, @option.class
    assert_equal Array, array.class
    assert array.include? [desc]
    assert array.include? short
    assert array.include? long
    assert array.include? default
    assert_equal proc { 1 + 1 }.call, array.select { |a| a.is_a? Proc }.first.call
  end
  
  def test_to_h
    desc = "This is your description."
    short = "-t"
    long = "--test=METHOD"
    cast = Integer
    
    @option.desc desc
    @option.short short
    @option.long long
    @option.cast cast
    @option.filter { 2 + 2 }
    hash = @option.to_h
        
    assert_equal Choice::Option, @option.class
    assert_equal Hash, hash.class
    assert_equal [desc], hash['desc']
    assert_equal short, hash['short']
    assert_equal cast, hash['cast']    
    assert_equal proc { 2 + 2 }.call, hash['filter'].call
  end
end
