$:.unshift "../lib:lib"
require 'test/unit'
require 'choice'

class TestWriter < Test::Unit::TestCase
  
  def setup
    Choice.reset!
  end
  
  HELP_OUT = ''
  def test_help
    song = Choice::Option.new do
      short '-s'
      long '--song=SONG'
      cast String
      desc 'Your favorite GNR song.'
      desc '(Default: MyMichelle)'
      default 'MyMichelle'
    end
    dude = Choice::Option.new do
      short '-d'
      long '--dude=DUDE'
      cast String
      desc 'Your favorite GNR dude.'
      desc '(Default: Slash)'
      default 'Slash'
    end

    options = [[:song, song], [:dude, dude]]
    args = { :banner => "Welcome to the jungle",
             :header => [""],
             :options => options,
             :footer => ["", "Wake up."] }

    help_string = <<-HELP
Welcome to the jungle

    -s, --song=SONG                  Your favorite GNR song.
                                     (Default: MyMichelle)
    -d, --dude=DUDE                  Your favorite GNR dude.
                                     (Default: Slash)

Wake up.
HELP

    Choice::Writer.help(args, HELP_OUT, true)
    
    assert_equal help_string, HELP_OUT
  end
  
  BANNER_OUT = ''
  def test_banner
    media = Choice::Option.new do
      short '-m'
      long '--media=MEDIA'
    end
    rom = Choice::Option.new do
      short '-r'
      long '--rom=ROM'
    end

    options = [[:media, media], [:rom, rom]]
    args = { :header => [""],
             :options => options }

    help_string = <<-HELP
Usage: #{program} [-mr]

    -m, --media=MEDIA                
    -r, --rom=ROM                    
HELP

    Choice::Writer.help(args, BANNER_OUT, true)
    
    assert_equal help_string, BANNER_OUT
  end
  
  SPILLOVER_OUT = ''
  def test_desc_spillover
    toolong = Choice::Option.new do
      long '--thisisgonnabewaytoolongiswear=STRING'
      desc 'Way too long, boy wonder.'
    end
    
    options = [[:toolong, toolong]]
    
    help_string = <<-HELP
Usage: #{program}
        --thisisgonnabewaytoolongiswear=STRING
                                     Way too long, boy wonder.
HELP
    

    Choice::Writer.help({:options => options}, SPILLOVER_OUT, true)
    
    assert_equal help_string, SPILLOVER_OUT
  end
  
  def program
    if (/(\/|\\)/ =~ $0) then File.basename($0) else $0 end  
  end
end
