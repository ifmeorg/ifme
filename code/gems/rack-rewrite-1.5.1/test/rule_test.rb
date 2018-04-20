require 'test_helper'

class RuleTest < Test::Unit::TestCase

  TEST_ROOT = File.dirname(__FILE__)

  def self.should_pass_maintenance_tests
    context 'and the maintenance file does in fact exist' do
      setup { File.stubs(:exists?).returns(true) }

      should('match for the root')              { assert @rule.matches?(rack_env_for('/')) }
      should('match for a regular rails route') { assert @rule.matches?(rack_env_for('/users/1')) }
      should('match for an html page')          { assert @rule.matches?(rack_env_for('/index.html')) }
      should('not match for a css file')        { assert !@rule.matches?(rack_env_for('/stylesheets/style.css')) }
      should('not match for a jpg file')        { assert !@rule.matches?(rack_env_for('/images/sls.jpg')) }
      should('not match for a png file')        { assert !@rule.matches?(rack_env_for('/images/sls.png')) }
    end
  end

  def self.negative_lookahead_supported?
    begin
      require 'oniguruma'
    rescue LoadError; end
    RUBY_VERSION =~ /^1\.9/ || Object.const_defined?(:Oniguruma)
  end

  def negative_lookahead_regexp
    if RUBY_VERSION =~ /^1\.9/
      # have to use the constructor instead of the literal syntax b/c load errors occur in Ruby 1.8
      Regexp.new("(.*)$(?<!css|png|jpg)")
    else
      Oniguruma::ORegexp.new("(.*)$(?<!css|png|jpg)")
    end
  end

  context '#Rule#apply' do
    supported_status_codes.each do |rule_type|
      should "set Location header to result of #interpret_to for a #{rule_type}" do
        rule = Rack::Rewrite::Rule.new(rule_type, %r{/abc}, '/def')
        env = {'PATH_INFO' => '/abc'}
        assert_equal rule.send(:interpret_to, '/abc'), rule.apply!(env)[1]['Location']
      end
    end

    supported_status_codes.each do |rule_type|
      should "include a link to the result of #interpret_to for a #{rule_type}" do
        rule = Rack::Rewrite::Rule.new(rule_type, %r{/abc}, '/def')
        env = {'PATH_INFO' => '/abc'}
        assert_match /\/def/, rule.apply!(env)[2][0]
      end
    end

    should 'keep the QUERY_STRING when a 301 rule matches a URL with a querystring' do
      rule = Rack::Rewrite::Rule.new(:r301, %r{/john(.*)}, '/yair$1')
      env = {'PATH_INFO' => '/john', 'QUERY_STRING' => 'show_bio=1'}
      assert_equal '/yair?show_bio=1', rule.apply!(env)[1]['Location']
    end

    should 'keep the QUERY_STRING when a rewrite rule that requires a querystring matches a URL with a querystring' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{/john(\?.*)}, '/yair$1')
      env = {'PATH_INFO' => '/john', 'QUERY_STRING' => 'show_bio=1'}
      rule.apply!(env)
      assert_equal '/yair', env['PATH_INFO']
      assert_equal 'show_bio=1', env['QUERY_STRING']
      assert_equal '/yair?show_bio=1', env['REQUEST_URI']
    end

    should 'update the QUERY_STRING when a rewrite rule changes its value' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{/(\w+)\?show_bio=(\d)}, '/$1?bio=$2')
      env = {'PATH_INFO' => '/john', 'QUERY_STRING' => 'show_bio=1'}
      rule.apply!(env)
      assert_equal '/john', env['PATH_INFO']
      assert_equal 'bio=1', env['QUERY_STRING']
      assert_equal '/john?bio=1', env['REQUEST_URI']
    end

    should 'set Content-Type header to text/html for a 301 and 302 request for a .html page' do
      supported_status_codes.each do |rule_type|
        rule = Rack::Rewrite::Rule.new(rule_type, %r{/abc}, '/def.html')
        env = {'PATH_INFO' => '/abc'}
        assert_equal 'text/html', rule.apply!(env)[1]['Content-Type']
      end
    end

    should 'set Content-Type header to text/css for a 301 and 302 request for a .css page' do
      supported_status_codes.each do |rule_type|
        rule = Rack::Rewrite::Rule.new(rule_type, %r{/abc}, '/def.css')
        env = {'PATH_INFO' => '/abc'}
        assert_equal 'text/css', rule.apply!(env)[1]['Content-Type']
      end
    end

    should 'set additional headers for a 301 and 302 request' do
      [:r301, :r302].each do |rule_type|
        rule = Rack::Rewrite::Rule.new(rule_type, %r{/abc}, '/def.css', {:headers => {'Cache-Control' => 'no-cache'}})
        env = {'PATH_INFO' => '/abc'}
        assert_equal 'no-cache', rule.apply!(env)[1]['Cache-Control']
      end
    end

    should 'evaluate additional headers block once per redirect request' do
      [:r301, :r302].each do |rule_type|
        header_val = 'foo'
        rule = Rack::Rewrite::Rule.new(rule_type, %r{/abc}, '/def.css', {:headers => lambda { {'X-Foobar' => header_val} } })
        env = {'PATH_INFO' => '/abc'}
        assert_equal 'foo', rule.apply!(env)[1]['X-Foobar']
        header_val = 'bar'
        assert_equal 'bar', rule.apply!(env)[1]['X-Foobar']
      end
    end

    should 'evaluate additional headers block once per send file request' do
      [:send_file, :x_send_file].each do |rule_type|
        header_val = 'foo'
        rule = Rack::Rewrite::Rule.new(rule_type, /.*/, File.join(TEST_ROOT, 'geminstaller.yml'), {:headers => lambda { {'X-Foobar' => header_val} } })
        env = {'PATH_INFO' => '/abc'}
        assert_equal 'foo', rule.apply!(env)[1]['X-Foobar']
        header_val = 'bar'
        assert_equal 'bar', rule.apply!(env)[1]['X-Foobar']
      end
    end

    context 'Given an :x_send_file rule that matches' do
      setup do
        @file = File.join(TEST_ROOT, 'geminstaller.yml')
        @rule = Rack::Rewrite::Rule.new(:x_send_file, /.*/, @file, :headers => {'Cache-Control' => 'no-cache'})
        env = {'PATH_INFO' => '/abc'}
        @response = @rule.apply!(env)
      end

      should 'return 200' do
        assert_equal 200, @response[0]
      end

      should 'return an X-Sendfile header' do
        assert @response[1].has_key?('X-Sendfile')
      end

      should 'return a Content-Type of text/yaml' do
        assert_equal 'text/yaml', @response[1]['Content-Type']
      end

      should 'return the proper Content-Length' do
        assert_equal File.size(@file).to_s, @response[1]['Content-Length']
      end

      should 'return additional headers' do
        assert_equal 'no-cache', @response[1]['Cache-Control']
      end

      should 'return empty content' do
        assert_equal [], @response[2]
      end
    end

    context 'Given a :send_file rule that matches' do
      setup do
        @file = File.join(TEST_ROOT, 'geminstaller.yml')
        @rule = Rack::Rewrite::Rule.new(:send_file, /.*/, @file, :headers => {'Cache-Control' => 'no-cache'})
        env = {'PATH_INFO' => '/abc'}
        @response = @rule.apply!(env)
      end

      should 'return 200' do
        assert_equal 200, @response[0]
      end

      should 'not return an X-Sendfile header' do
        assert !@response[1].has_key?('X-Sendfile')
      end

      should 'return a Content-Type of text/yaml' do
        assert_equal 'text/yaml', @response[1]['Content-Type']
      end

      should 'return the proper Content-Length' do
        assert_equal File.size(@file).to_s, @response[1]['Content-Length']
      end

      should 'return additional headers' do
        assert_equal 'no-cache', @response[1]['Cache-Control']
      end

      should 'return the contents of geminstaller.yml in an array for Ruby 1.9.2 compatibility' do
        assert_equal [File.read(@file)], @response[2]
      end
    end

    should 'return proper status for send_file or x_send_file if specified' do
      [:send_file, :x_send_file].each do |rule_type|
        file = File.join(TEST_ROOT, 'geminstaller.yml')
        rule = Rack::Rewrite::Rule.new(rule_type, /.*/, file, :status => 503)
        env = {'PATH_INFO' => '/abc'}
        assert_equal 503, rule.apply!(env)[0]
      end
    end

  end

  context 'Rule#matches' do
    context 'Given rule with :not option which matches "from" string' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, /^\/features/, '/facial_features', :not => '/features')
      end
      should 'not match PATH_INFO of /features' do
        assert !@rule.matches?(rack_env_for("/features"))
      end
      should 'match PATH_INFO of /features.xml' do
        assert @rule.matches?(rack_env_for("/features.xml"))
      end
    end

    context 'Given rule with :host option of testapp.com' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, /^\/features/, '/facial_features', :host => 'testapp.com')
      end

      should 'match PATH_INFO of /features and HOST of testapp.com' do
        assert @rule.matches?(rack_env_for("/features", 'SERVER_NAME' => 'testapp.com', "SERVER_PORT" => "8080"))
      end

      should 'not match PATH_INFO of /features and HOST of nottestapp.com' do
        assert ! @rule.matches?(rack_env_for("/features", 'SERVER_NAME' => 'nottestapp.com', "SERVER_PORT" => "8080"))
      end

      should 'match PATH_INFO of /features AND HTTP_X_FORWARDED_HOST of testapp.com and SERVER_NAME of 127.0.0.1' do
        assert @rule.matches?(rack_env_for("/features", "SERVER_NAME" => "127.0.0.1", "SERVER_PORT" => "8080", "HTTP_X_FORWARDED_HOST" => "testapp.com"))
      end

      should 'not match PATH_INFO of /features AND HTTP_X_FORWARDED_HOST of nottestapp.com and SERVER_NAME of 127.0.0.1' do
        assert !@rule.matches?(rack_env_for("/features", "SERVER_NAME" => "127.0.0.1", "SERVER_PORT" => "8080", "HTTP_X_FORWARDED_HOST" => "nottestapp.com"))
      end
    end

    context 'Given rule with :method option of POST' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, '/features', '/facial_features', :method => 'POST')
      end

      should 'match PATH_INFO of /features and REQUEST_METHOD of POST' do
        assert @rule.matches?(rack_env_for("/features", 'REQUEST_METHOD' => 'POST'))
      end

      should 'not match PATH_INFO of /features and REQUEST_METHOD of DELETE' do
        assert ! @rule.matches?(rack_env_for("/features", 'REQUEST_METHOD' => 'DELETE'))
      end
    end

    context 'Given any rule with a "from" string of /features' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, '/features', '/facial_features')
      end

      should 'match PATH_INFO of /features' do
        assert @rule.matches?(rack_env_for("/features"))
      end

      should 'not match PATH_INFO of /features.xml' do
        assert !@rule.matches?(rack_env_for("/features.xml"))
      end

      should 'not match PATH_INFO of /my_features' do
        assert !@rule.matches?(rack_env_for("/my_features"))
      end
    end

    context 'Given a rule with the ^ operator' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, %r{^/jason}, '/steve')
      end
      should 'match with the ^ operator if match is at the beginning of the path' do
        assert @rule.matches?(rack_env_for('/jason'))
      end

      should 'not match with the ^ operator when match is deeply nested' do
        assert !@rule.matches?(rack_env_for('/foo/bar/jason'))
      end
    end

    context 'Given any rule with a "from" regular expression of /features(.*)' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, %r{/features(.*)}, '/facial_features$1')
      end

      should 'match PATH_INFO of /features' do
        assert @rule.matches?(rack_env_for("/features"))
      end

      should 'match PATH_INFO of /features.xml' do
        assert @rule.matches?(rack_env_for('/features.xml'))
      end

      should 'match PATH_INFO of /features/1' do
        assert @rule.matches?(rack_env_for('/features/1'))
      end

      should 'match PATH_INFO of /features?filter_by=name' do
        assert @rule.matches?(rack_env_for('/features?filter_by_name=name'))
      end

      should 'match PATH_INFO of /features/1?hide_bio=1' do
        assert @rule.matches?(rack_env_for('/features/1?hide_bio=1'))
      end
    end

    context 'Given a rule with a guard that checks for the presence of a file' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, %r{(.)*}, '/maintenance.html', lambda { |rack_env|
          File.exists?('maintenance.html')
        })
      end

      context 'when the file exists' do
        setup do
          File.stubs(:exists?).returns(true)
        end

        should 'match' do
          assert @rule.matches?(rack_env_for('/anything/should/match'))
        end
      end

      context 'when the file does not exist' do
        setup do
          File.stubs(:exists?).returns(false)
        end

        should 'not match' do
          assert !@rule.matches?(rack_env_for('/nothing/should/match'))
        end
      end
    end

    context 'Given the capistrano maintenance.html rewrite rule given in our README' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:rewrite, /.*/, '/system/maintenance.html', lambda { |rack_env|
          maintenance_file = File.join('system', 'maintenance.html')
          File.exists?(maintenance_file) && rack_env['PATH_INFO'] !~ /\.(css|jpg|png)/
        })
      end
      should_pass_maintenance_tests
    end

    if negative_lookahead_supported?
      context 'Given the negative lookahead regular expression version of the capistrano maintenance.html rewrite rule given in our README' do
        setup do
          @rule = Rack::Rewrite::Rule.new(:rewrite, negative_lookahead_regexp, '/system/maintenance.html', lambda { |rack_env|
            File.exists?(File.join('public', 'system', 'maintenance.html'))
          })
        end
        should_pass_maintenance_tests
      end
    end

    context 'Given the CNAME alternative rewrite rule in our README' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:r301, %r{.*}, 'http://mynewdomain.com$&', lambda {|rack_env|
          rack_env['SERVER_NAME'] != 'mynewdomain.com'
        })
      end

      should 'match requests for domain myolddomain.com and redirect to mynewdomain.com' do
        env = {'PATH_INFO' => '/anything', 'QUERY_STRING' => 'abc=1', 'SERVER_NAME' => 'myolddomain.com'}
        assert @rule.matches?(env)
        rack_response = @rule.apply!(env)
        assert_equal 'http://mynewdomain.com/anything?abc=1', rack_response[1]['Location']
      end

      should 'not match requests for domain mynewdomain.com' do
        assert !@rule.matches?({'PATH_INFO' => '/anything', 'SERVER_NAME' => 'mynewdomain.com'})
      end
    end

    context 'Given a lambda matcher' do
      setup do
        @rule = Rack::Rewrite::Rule.new(:r302, ->{ Thread.current[:test_matcher] }, '/today' )
      end
      should 'call the lambda and match appropriately' do
        Thread.current[:test_matcher] = '/abcd'
        assert @rule.matches?(rack_env_for("/abcd"))
        assert !@rule.matches?(rack_env_for("/DEFG"))
        Thread.current[:test_matcher] = /DEFG$/
        assert !@rule.matches?(rack_env_for("/abcd"))
        assert @rule.matches?(rack_env_for("/DEFG"))
      end
    end
  end

  context 'Rule#interpret_to' do
    should 'return #to when #from is a string' do
      rule = Rack::Rewrite::Rule.new(:rewrite, '/abc', '/def')
      assert_equal '/def', rule.send(:interpret_to, rack_env_for('/abc'))
    end

    should 'replace $1 on a match' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{/person_(\d+)}, '/people/$1')
      assert_equal '/people/1', rule.send(:interpret_to, rack_env_for("/person_1"))
    end

    should 'be able to catch querystrings with a regexp match' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{/person_(\d+)(.*)}, '/people/$1$2')
      assert_equal '/people/1?show_bio=1', rule.send(:interpret_to, rack_env_for('/person_1?show_bio=1'))
    end

    should 'be able to make 10 replacements' do
      # regexp to reverse 10 characters
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{(\w)(\w)(\w)(\w)(\w)(\w)(\w)(\w)(\w)(\w)}, '$10$9$8$7$6$5$4$3$2$1')
      assert_equal 'jihgfedcba', rule.send(:interpret_to, rack_env_for("abcdefghij"))
    end

    should 'replace $& on a match' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{.*}, 'http://example.org$&')
      assert_equal 'http://example.org/person/1', rule.send(:interpret_to, rack_env_for("/person/1"))
    end

    should 'ignore empty captures' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{/person(_\d+)?}, '/people/$1')
      assert_equal '/people/', rule.send(:interpret_to, rack_env_for("/person"))
    end

    should 'call to with from when it is a lambda' do
      rule = Rack::Rewrite::Rule.new(:rewrite, 'a', lambda { |from, env| from * 2 })
      assert_equal 'aa', rule.send(:interpret_to, rack_env_for('a'))
    end

    should 'call to with from match data' do
      rule = Rack::Rewrite::Rule.new(:rewrite, %r{/person_(\d+)(.*)}, lambda {|match, env| "people-#{match[1].to_i * 3}#{match[2]}"})
      assert_equal 'people-3?show_bio=1', rule.send(:interpret_to, rack_env_for('/person_1?show_bio=1'))
    end

    should 'call to with from lambda match data' do
      rule = Rack::Rewrite::Rule.new(:rewrite, ->{ Thread.current[:test_matcher]}, ->(match, env){ match[1][0] })
      Thread.current[:test_matcher] = /^\/(alpha|beta|gamma)$/
      assert_equal 'b', rule.send(:interpret_to, rack_env_for('/beta'))
      Thread.current[:test_matcher] = /^\/(zulu)/
      assert_equal 'z', rule.send(:interpret_to, rack_env_for('/zulu'))
    end
  end

  context 'Mongel 1.2.0.pre2 edge case: root url with a query string' do
    should 'handle a nil PATH_INFO variable without errors' do
      rule = Rack::Rewrite::Rule.new(:r301, '/a', '/')
      assert_equal '?exists', rule.send(:build_path_from_env, {'QUERY_STRING' => 'exists'})
    end
  end

  def rack_env_for(url, options = {})
    components = url.split('?')
    {'PATH_INFO' => components[0], 'QUERY_STRING' => components[1] || ''}.merge(options)
  end
end
