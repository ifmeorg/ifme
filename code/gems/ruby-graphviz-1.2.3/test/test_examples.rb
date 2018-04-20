class GraphVizTest < Test::Unit::TestCase
  # you can run a subset of all the samples like this:
  #  ruby test/test_examples.rb  --name='/sample3[6-9]/'
  #
  # The above will run samples 36, 37, 38, and 39
  #
  RootDir    = File.expand_path('../..', __FILE__)
  ExampleDir = File.join(RootDir,'examples')
  OutputDir  = File.join(File.dirname(__FILE__),'output')

  # the below tests write to stdout. the other tests write to filesystem
  Skips = {
    #'35' => 'hanging for me',
    '33' => 'FamilyTree is broken',
    '36' => 'hangs for me',
    '53' => 'FamilyTree is broken',
    '57' => 'will not be able to find the graphml script',
    '98' => 'This test is just for debug',
    '99' => 'FamilyTree is broken'
  }

  def test_sample07
    assert_output_pattern(/\Adigraph structs \{.+\}\n\Z/m, '07')
  end

  def test_sample22
    assert_output_pattern(/\Adigraph mainmap \{.+\}\n\Z/m, '22')
  end

  def test_sample23
    assert_output_pattern(%r{\A<map.+</map>\n\Z}m, '23')
  end

  def test_sample27
    assert_output_pattern(/\Adigraph G \{.*\}\n\Z/m, '27')
  end

  def test_sample38
    assert_output_pattern(/\Adigraph G \{.*\}\n\Z/m, '38')
  end

  def test_sample40
    assert_output_pattern(/\Adigraph G \{.*\}\n\Z/m, '40')
  end

  def test_sample41
    assert_output_pattern(/\A.*\Z/m, '40')
  end

  def test_sample55
    assert_output_pattern(/\Agraph G \{.*\}\n\Z/m, '55')
  end

  def test_sample62
     assert_output_pattern(/\ANode.*\n\Z/m, '62')
  end

  def test_sample70
    assert_output_pattern(/\Agraph G \{.*\}\n\Z/m, '70')
  end

  #
  # for every sample file in the examples directory that matches the
  # pattern ("sample01.rb, sample02.rb, etc) make a corresponding
  # test method: test_sample01(), test_sample02(), etc.  To actually define
  # this methods in this way instead of just iterating over the list of files
  # will make it easier to use command-line options to isolate certain
  # tests,
  #   (for example:   ruby test/test_examples.rb --name '/sample0[1-5]/' )
  # and to integrate better with certain kinds of test output and
  # reporting tools.
  #
  # we will skip over any methods already defined
  #

  @last_image_path = nil
  @number_to_path = {}
  class << self
    def make_sample_test_method path
      fail("failed match: #{path}") unless
        matches = %r{/(sample(\d\d))\.rb\Z}.match(path)
      basename, number = matches.captures
      number_to_path[number] = path
      meth = "test_#{basename}"
      return if method_defined?(meth)  # if we hand-write one
      if Skips[number]
        puts "skipping #{basename} - #{Skips[number]}"
        return
      end
      define_method(meth){ assert_sample_file_has_no_output(path) }
    end
    attr_accessor :last_image_path, :number_to_path
  end

  if File.directory? OutputDir
    FileUtils.rm_rf OutputDir
  end
  FileUtils.cp_r ExampleDir, OutputDir
  
  samples = Dir[File.join(OutputDir,'sample*.rb')].sort
  samples.each {|path| make_sample_test_method(path) }

private

  def assert_output_pattern tgt_regexp, number
    path = self.class.number_to_path[number]
    out, err, _ = Open3.capture3("ruby #{path}")
    assert_equal "", err, "no errors"
    assert_match tgt_regexp, out.gsub(/\r\n/, "\n"), "output for sample#{number} should match regexp"
  end

  def assert_sample_file_has_no_output path
    begin
      out, err, _ = Open3.capture3("ruby #{path}")
      assert_equal(0, out.length, "expecting empty output got [#{out}]")
      assert_equal(0, err.length, "expecting empty errorput got [#{err}]")
    rescue Exception => e
      assert(false, "got exception on #{File.basename(path)}: #{e.message}")
    end
  end

  def setup_sample path
    unless File.directory? OutputDir
      FileUtils.mkdir_p(OutputDir, :verbose => true)
    end
    ARGV[0] = nil if ARGV.any? # hack trigger searching for 'dot' executable
  end

  def run_sample(path)
    run_path = File.join(OutputDir, File.basename(path))
    FileUtils.cp path, run_path
    out, err, _ = Open3.capture3("ruby #{run_path}")
    return out, err
  end
end
