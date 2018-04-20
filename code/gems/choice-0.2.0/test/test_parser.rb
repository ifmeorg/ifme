$:.unshift "../lib:lib"
require 'test/unit'
require 'choice/option'
require 'choice/parser'

class TestParser < Test::Unit::TestCase
  def setup
    @options = {}
  end
  
  def test_parse_options
    @options['band'] = Choice::Option.new do
      short '-b'
      long '--band=BAND'
      cast String
      desc 'Your favorite band.'
    end
    @options['animal'] = Choice::Option.new do
      short '-a'
      long '--animal=ANIMAL'
      cast String
      desc 'Your favorite animal.'
    end      
    band = 'Led Zeppelin'
    animal = 'Reindeer'
    
    args = ['-b', band, "--animal=#{animal}"]
          
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal band, choices['band']
    assert_equal animal, choices['animal']
  end
  
  def test_parse_no_options
    assert_equal Hash.new, Choice::Parser.parse(nil, nil)
  end
  
  def test_parse_default
    @options['soda'] = Choice::Option.new do
      short '-s'
      long '--soda=SODA'
      default 'PibbJr'
    end
    
    args = []
    
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal 'PibbJr', choices['soda']
  end
  
  def test_parse_options_with_filters
    @options['host'] = Choice::Option.new do
      short '-h'
      filter do |opt|
        opt.gsub!(/[^\w]/, '')
        opt = opt.sub(/k/, 'c')
      end
    end     
    host = 'de.fun.kt'
    args = ['-h', host]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal 'defunct', choices['host']
  end 
  
  def test_casting
    @options['port'] = Choice::Option.new do
      short '-p'
      cast Integer
    end
    
    port = '3000'
    args = ['-p', port]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal port.to_i, choices['port']
  end
  
  def test_text_required
    @options['name'] = Choice::Option.new do
      short '-n'
      long '--name=NAME'
    end
    @options['age'] = Choice::Option.new do
      short '-a'
      long 'age[=AGE]'
      cast Integer
    end
    
    args = ['-n', '-a', '21']
    
    assert_raise(Choice::Parser::ArgumentRequired) do
      choices, rest = Choice::Parser.parse(@options, args)
    end
  end
  
  def test_text_optional
    @options['color'] = Choice::Option.new do
      short '-c'
      long '--color[=COLOR]'
    end
    
    args = ['-c']
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert choices['color']
    
    color = 'ladyblue'
    args = ['-c', color]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal color, choices['color']
  end

  def test_text_optional_deprecated
    @options['color'] = Choice::Option.new do
      short '-c'
      long '--color=[COLOR]'
    end
    
    args = ['-c']
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert choices['color']
    
    color = 'ladyblue'
    args = ['-c', color]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal color, choices['color']
  end
  
  def test_ignore_separator
    options = []
    options << ['keyboard', Choice::Option.new do
      short '-k'
      long '--keyboard=BOARD'
    end]
    
    options << ['mouse', Choice::Option.new do
      short '-m'
      long '--mouse=MOUSE'
    end]
    
    args = ['-m', 'onebutton']
    choices, rest = Choice::Parser.parse([options.first, '----', options.last], args)
    
    assert choices['mouse']
    assert_equal 1, choices.size
  end
  
  def test_long_as_switch
    @options['chunky'] = Choice::Option.new do
      short '-b'
      long '--bacon'
    end

    args = ['--bacon']
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert choices['chunky']
  end
  
  def test_validate_regexp
    @options['email'] = Choice::Option.new do
      short '-e'
      long '--email=EMAIL'
      desc 'Your valid email addy.'
      validate /^[a-z0-9_.-]+@[a-z0-9_.-]+\.[a-z]{2,4}$/i
    end

    email_bad = 'this will@neverwork'    
    email_good = 'chris@ozmm.org'
    
    args = ['-e', email_bad]
    assert_raise(Choice::Parser::ArgumentValidationFails) do
      choices, rest = Choice::Parser.parse(@options, args)
    end

    args = ['-e', email_good]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal email_good, choices['email']
  end
  
  def test_validate_block
    @options['file'] = Choice::Option.new do
      short '-f'
      long '--file=FILE'
      desc 'Your valid email addy.'
      validate do |arg|
        File.exists? arg
      end
    end

    file_bad = 'not_a_file.rb'
    file_good = __FILE__
    
    args = ['-f', file_bad]
    assert_raise(Choice::Parser::ArgumentValidationFails) do
      choices, rest = Choice::Parser.parse(@options, args)
    end

    args = ['-f', file_good]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal file_good, choices['file']
  end

  def test_unknown_argument
    @options['cd'] = Choice::Option.new do
      short '-c'
      long '--cd=CD'
      desc 'A CD you like.'
    end
  
    args = ['-c', 'BestOfYanni', '--grace']
    assert_raise(Choice::Parser::UnknownOption) do
      choices, rest = Choice::Parser.parse(@options, args)
    end
  end

  def test_valid
    @options['suit'] = Choice::Option.new do
      short '-s'
      long '--suit=SUIT'
      valid %w[club diamond spade heart]
      desc "The suit of your card, sir."
    end

    suit_good = 'club'
    suit_bad = 'joker'
    
    args = ['-s', suit_bad]
    assert_raise(Choice::Parser::InvalidArgument) do
      choices, rest = Choice::Parser.parse(@options, args)
    end

    args = ['-s', suit_good]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal suit_good, choices['suit']
  end

  def test_valid_needs_argument
    @options['pants'] = Choice::Option.new do
      short '-p'
      long '--pants'
      valid %w[jeans slacks trunks boxers]
      desc "Your preferred type of pants."
    end
    
    args = ['-p']
    assert_raise(Choice::Parser::ArgumentRequiredWithValid) do
      choices, rest = Choice::Parser.parse(@options, args)
    end
  end

  def test_long_as_array
    @options['medium'] = Choice::Option.new do
      short '-m'
      long '--medium=*MEDIUM'
      desc "The medium(s) you like best."
    end

    mediums = %w[canvas stone steel]

    args = ['-m', mediums.first, '-m',  mediums[1], '-m', mediums.last]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal mediums, choices['medium']

    args = ['-m', mediums.first, mediums[1], mediums.last]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal mediums, choices['medium']

    args = ["--medium=#{mediums.first}", "--medium=#{mediums[1]}", "--medium=#{mediums.last}"]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal mediums, choices['medium']

    args = ["--medium=#{mediums.first}", mediums[1], mediums.last]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal mediums, choices['medium']
  end

  def test_long_as_array_optional
    @options['instruments'] = Choice::Option.new do
      short '-i'
      long '--instruments[=*INSTRUMENTS]'
      desc "Do you like instruments?  Which ones do you like best?"
    end

    instruments = %w[xylophone guitar piano]

    args = ["--instruments=#{instruments.first}", "--instruments=#{instruments[1]}", 
            "--instruments=#{instruments.last}"]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal instruments, choices['instruments']

    args = %w[--instruments]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal true, choices['instruments']
  end

  def test_long_as_array_with_valid
    @options['suits'] = Choice::Option.new do
      short '-s'
      long '--suits=*SUITS'
      valid %w[club diamond spade heart]
      desc "The suits of your deck, sir."
    end

    suits = %w[spade heart]

    args = ['-s', suits.first, suits.last]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal suits, choices['suits']
    
    args = ['-s', suits.first, 'notasuit']
    assert_raise(Choice::Parser::InvalidArgument) do
      choices, rest = Choice::Parser.parse(@options, args)
    end
  end

  def test_long_with_spaces
    @options['donut'] = Choice::Option.new do
      short '-d'
      long '--donut DONUT'
      desc "Your favorite donut style."
    end

    donut = 'long-john'

    args = ['--donut', donut]
    choices, rest = Choice::Parser.parse(@options, args)
    
    assert_equal donut, choices['donut']
  end

  def test_optional_long_with_spaces
    @options['donut'] = Choice::Option.new do
      short '-d'
      long '--donut [DONUT]'
      desc "Your favorite donut style."
    end

    donut = 'chocolate'

    args = ['--donut', donut]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal donut, choices['donut']

    args = ['--donut']
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal true, choices['donut']
  end

  def test_long_with_spaces_arrayed
    @options['donuts'] = Choice::Option.new do
      short '-d'
      long '--donuts *DONUTS'
      desc "Your favorite donut styles."
    end

    donuts = %w[glazed cream-filled]

    args = ['--donuts', donuts.first, donuts.last]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal donuts, choices['donuts']
  end
  
  def test_long_with_rest
    @options['donut'] = Choice::Option.new do
      short '-d'
      long '--donut [DONUT]'
      desc "Your favorite donut style."
    end

    donut = 'chocolate'

    args = ['eat', '--donut', donut]
    choices, rest = Choice::Parser.parse(@options, args)
    assert_equal donut, choices['donut']
    assert_equal ['eat'], rest
  end
end
