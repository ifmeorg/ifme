module Choice
  
  # The Option class parses and stores all the information about a specific
  # option.
  class Option #:nodoc: all

    # Since we define getters/setters on the fly, we need a white list of
    # which to accept.  Here's the list.
    CHOICES = %w[short long desc default filter action cast validate valid]

    # You can instantiate an option on its own or by passing it a name and
    # a block.  If you give it a block, it will eval() the block and set itself
    # up nicely.
    def initialize(options = {}, &block)
      # Here we store the definitions this option contains, to make to_a and
      # to_h easier.
      @choices = []      

      # If we got a block, eval it and set everything up.
      instance_eval(&block) if block_given?      

      # Is this option required?
      @required = options[:required] || false
      @choices << 'required'
    end
       
    # This is the catch all for the getter/setter choices defined in CHOICES.
    # It also gives us choice? methods.
    def method_missing(method, *args, &block)
      # Get the name of the choice we want, as a class variable string.
      var = "@#{method.to_s.sub('?','')}"

      # To string, for regex purposes.
      method = method.to_s
      
      # Don't let in any choices not defined in our white list array.
      raise ParseError, "I don't know `#{method}'" unless CHOICES.include? method.sub('?','')
      
      # If we're asking a question, give an answer.  Like 'short?'.
      return !!instance_variable_get(var) if method =~ /\?/ 
      
      # If we were called with no arguments, we want a get.
      return instance_variable_get(var) unless args[0] || block_given?
      
      # If we were given a block or an argument, save it.
      instance_variable_set(var, args[0]) if args[0]
      instance_variable_set(var, block) if block_given?
      
      # Add the choice to the @choices array if we're setting it for the first
      # time.
      @choices << method if args[0] || block_given? unless @choices.index(method)
    end
    
    # The desc method is slightly special: it stores itself as an array and
    # each subsequent call adds to that array, rather than overwriting it.
    # This is so we can do multi-line descriptions easily.
    def desc(string = nil)
      return @desc if string.nil?

      @desc ||= []
      @desc.push(string)

      # Only add to @choices array if it's not already present.
      @choices << 'desc' unless @choices.index('desc')
    end
    
    # Simple, desc question method.
    def desc?() !!@desc end

    # Returns Option converted to an array.
    def to_a
      @choices.inject([]) do |array, choice|
        return array unless @choices.include? choice
        array + [instance_variable_get("@#{choice}")]
      end
    end
    
    # Returns Option converted to a hash.
    def to_h
      @choices.inject({}) do |hash, choice|
        return hash unless @choices.include? choice
        hash.merge choice => instance_variable_get("@#{choice}") 
      end
    end
    
    # In case someone tries to use a method we don't know about in their 
    # option block.
    class ParseError < Exception; end    
  end
end
