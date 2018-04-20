module Rack
  autoload :RuleSet, 'rack/rewrite/rule'
  autoload :VERSION, 'rack/rewrite/version'
  
  # A rack middleware for defining and applying rewrite rules. In many cases you 
  # can get away with rack-rewrite instead of writing Apache mod_rewrite rules.  
  class Rewrite
    def initialize(app, given_options = {}, &rule_block)
      options = {
          :klass => RuleSet,
          :options => {}
      }.merge(given_options)
      @app = app
      @rule_set = options[:klass].new(options[:options])
      @rule_set.instance_eval(&rule_block) if block_given?
    end
    
    def call(env)
      if matched_rule = find_first_matching_rule(env)
        rack_response = matched_rule.apply!(env)
        # Don't invoke the app if applying the rule returns a rack response
        return rack_response unless rack_response === true
      end
      @app.call(env)
    end
        
    private
      def find_first_matching_rule(env) #:nodoc:
        @rule_set.rules.detect { |rule| rule.matches?(env) }
      end    
  end
end
