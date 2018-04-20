$:.unshift "../lib:lib"
require 'test/unit'
require 'choice'

$VERBOSE = nil

class TestChoice < Test::Unit::TestCase

  def setup
    Choice.reset!
    Choice.dont_exit_on_help = true
    Choice.send(:class_variable_set, '@@choices', {})
  end

  def test_choices
    Choice.options do
      header "Tell me about yourself?"
      header ""
      option :band do
        short "-b"
        long "--band=BAND"
        cast String
        desc "Your favorite band."
        validate /\w+/
      end
      option :animal do
        short "-a"
        long "--animal=ANIMAL"
        cast String
        desc "Your favorite animal."
      end
      footer ""
      footer "--help This message"
    end

    band = 'LedZeppelin'
    animal = 'Reindeer'

    args = ['-b', band, "--animal=#{animal}"]
    Choice.args = args

    assert_equal band, Choice.choices['band']
    assert_equal animal, Choice.choices[:animal]
    assert_equal ["Tell me about yourself?", ""], Choice.header
    assert_equal ["", "--help This message"], Choice.footer

    assert_equal Choice.choices['band'], Choice['band']
    assert_equal Choice.choices[:animal], Choice[:animal]
  end

  def test_failed_parse
    assert_equal nil, Choice.parse
  end

  HELP_STRING = ''
  def test_help
    Choice.output_to(HELP_STRING)

    Choice.options do
      banner "Usage: choice [-mu]"
      header ""
      option :meal do
        short '-m'
        desc 'Your favorite meal.'
      end

      separator ""
      separator "And you eat it with..."

      option :utencil do
        short "-u"
        long "--utencil[=UTENCIL]"
        desc "Your favorite eating utencil."
      end
    end

    Choice.args = ['-m', 'lunch', '--help']

    help_string = <<-HELP
Usage: choice [-mu]

    -m                               Your favorite meal.

And you eat it with...
    -u, --utencil[=UTENCIL]          Your favorite eating utencil.
    HELP

    assert_equal help_string, HELP_STRING
  end

  UNKNOWN_STRING = ''
  def test_unknown_argument
    Choice.output_to(UNKNOWN_STRING)

    Choice.options do
      banner "Usage: choice [-mu]"
      header ""
      option :meal do
        short '-m'
        desc 'Your favorite meal.'
      end

      separator ""
      separator "And you eat it with..."

      option :utencil do
        short "-u"
        long "--utencil[=UTENCIL]"
        desc "Your favorite eating utencil."
      end
    end

    Choice.args = ['-m', 'lunch', '--motorcycles']

    help_string = <<-HELP
Usage: choice [-mu]

    -m                               Your favorite meal.

And you eat it with...
    -u, --utencil[=UTENCIL]          Your favorite eating utencil.
    HELP

    assert_equal help_string, UNKNOWN_STRING
  end

  REQUIRED_STRING = ''
  def test_required_argument
    Choice.output_to(REQUIRED_STRING)

    Choice.options do
      banner "Usage: choice [-mu]"
      header ""
      option :meal, :required => true do
        short '-m'
        desc 'Your favorite meal.'
      end

      separator ""
      separator "And you eat it with..."

      option :utencil do
        short "-u"
        long "--utencil[=UTENCIL]"
        desc "Your favorite eating utencil."
      end
    end

    Choice.args = ['-u', 'spork']

    help_string = <<-HELP
Usage: choice [-mu]

    -m                               Your favorite meal.

And you eat it with...
    -u, --utencil[=UTENCIL]          Your favorite eating utencil.
    HELP

    assert_equal help_string, REQUIRED_STRING
  end

  def test_shorthand_choices
    Choice.options do
      header "Tell me about yourself?"
      header ""
      options :band => { :short => "-b", :long => "--band=BAND", :cast => String, :desc => ["Your favorite band.", "Something cool."],
                         :validate => /\w+/ },
                         :animal => { :short => "-a", :long => "--animal=ANIMAL", :cast => String, :desc => "Your favorite animal." }

      footer ""
      footer "--help This message"
    end

    band = 'LedZeppelin'
    animal = 'Reindeer'

    args = ['-b', band, "--animal=#{animal}"]
    Choice.args = args

    assert_equal band, Choice.choices['band']
    assert_equal animal, Choice.choices[:animal]
    assert_equal ["Tell me about yourself?", ""], Choice.header
    assert_equal ["", "--help This message"], Choice.footer
  end

  def test_args_of
    suits = %w[clubs diamonds spades hearts]
    stringed_numerics = (1..13).to_a.map { |a| a.to_s }
    valid_cards = stringed_numerics + %w[jack queen king ace]
    cards = {}
    stringed_numerics.each { |n| cards[n] = n }
    cards.merge!('1' => 'ace', '11' => 'jack', '12' => 'queen', '13' => 'king')

    Choice.options do
      header "Gambling is fun again!  Pick a card and a suit (or two), then see if you win!"
      header ""
      header "Options:" 

      option :suit, :required => true do
        short '-s'
        long '--suit *SUITS'
        desc "The suit you wish to choose.  Required.  You can pass in more than one, even."
        desc "  Valid suits: #{suits * ' '}"
        valid suits
      end

      separator ''

      option :card, :required => true do
        short '-c'
        long '--card CARD'
        desc "The card you wish to gamble on.  Required.  Only one, please."
        desc "  Valid cards: 1 - 13, jack, queen, king, ace"
        valid valid_cards
        cast String
      end

      #cheat! to test --option=
      option :autowin do
        short '-a'
        long '--autowin=PLAYER'
        desc 'The person who should automatically win every time'
        desc 'Beware: raises the suspitions of other players'
      end
    end

    args = ["-c", "king", "--suit", "clubs", "diamonds", "spades", "hearts", "--autowin", "Grant"]
    Choice.args = args
    assert_equal ["king"], Choice.args_of("-c")
    assert_equal ["clubs", "diamonds", "spades", "hearts"], Choice.args_of("--suit")
    assert_equal ["Grant"], Choice.args_of("--autowin")
  end
end
