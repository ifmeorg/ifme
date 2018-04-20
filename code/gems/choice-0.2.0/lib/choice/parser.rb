module Choice
  
  # The parser takes our option definitions and our arguments and produces
  # a hash of values.
  module Parser #:nodoc: all
    extend self
    
    # What method to call on an object for each given 'cast' value.
    CAST_METHODS = { Integer => :to_i, String => :to_s, Float => :to_f,
                     Symbol => :to_sym }
    
    # Perhaps this method does too much.  It is, however, a parser.
    # You pass it an array of arrays, the first element of each element being
    # the option's name and the second element being a hash of the option's
    # info.  You also pass in your current arguments, so it knows what to
    # check against.
    def parse(options, args)
      # Return empty hash if the parsing adventure would be fruitless.
      return {} if options.nil? || !options || args.nil? || !args.is_a?(Array)
      
      # Operate on a copy of the inputs
      args = args.dup
      
      # If we are passed an array, make the best of it by converting it
      # to a hash.
      options = options.inject({}) do |hash, value|
        value.is_a?(Array) ? hash.merge(value.first => value[1]) : hash
      end if options.is_a? Array
      
      # Define local hashes we're going to use.  choices is where we store
      # the actual values we've pulled from the argument list.
      hashes, longs, required, validators, choices, arrayed = {}, {}, {}, {}, {}, {}
      hard_required = {}

      # We can define these on the fly because they are all so similar.
      params = %w[short cast filter action default valid]
      params.each { |param| hashes["#{param}s"] = {} }

      # Inspect each option and move its info into our local hashes.
      options.each do |name, obj|
        name = name.to_s

        # Only take hashes or hash-like duck objects.
        raise HashExpectedForOption unless obj.respond_to? :to_h
        obj = obj.to_h 

        # Is this option required?
        hard_required[name] = true if obj['required']

        # Set the local hashes if the value exists on this option object.
        params.each { |param| hashes["#{param}s"][name] = obj[param] if obj[param] }
        
        # If there is a validate statement, make it a regex or proc.
        validators[name] = make_validation(obj['validate']) if obj['validate']
        
        # Parse the long option. If it contains a =, figure out if the 
        # argument is required or optional.  Optional arguments are formed
        # like [=ARG], whereas required are just ARG (in --long=ARG style).
        if obj['long'] && obj['long'] =~ /(=|\[| )/
          # Save the separator we used, as we're gonna need it, then split
          sep = $1
          option, *argument = obj['long'].split(sep)

          # The actual name of the long switch
          longs[name] = option

          # Preserve the original argument, as it may contain [ or =,
          # by joining with the character we split on.  Add a [ in front if
          # we split on that.
          argument = (sep == '[' ? '[' : '') << Array(argument).join(sep)

          # Do we expect multiple arguments which get turned into an array?
          arrayed[name] = true if argument =~ /^\[?=?\*(.+)\]?$/
         
          # Is this long required or optional?
          required[name] = true unless argument =~ /^\[=?\*?(.+)\]$/
        elsif obj['long']
          # We can't have a long as a switch when valid is set -- die.
          raise ArgumentRequiredWithValid if obj['valid']

          # Set without any checking if it's just --long
          longs[name] = obj['long']
        end

        # If we were given a list of valid arguments with 'valid,' this option
        # is definitely required.
        required[name] = true if obj['valid']
      end
      
      rest = []
      
      # Go through the arguments and try to figure out whom they belong to
      # at this point.
      while arg = args.shift
        if hashes['shorts'].value?(arg)
          # Set the value to the next element in the args array since
          # this is a short.

          # If the next argument isn't a value, set this value to true
          if args.empty? || args.first.match(/^-/)
            value = true
          else
            value = args.shift
          end

          # Add this value to the choices hash with the key of the option's
          # name.  If we expect an array, tack this argument on.
          name = hashes['shorts'].key(arg)
          if arrayed[name]
            choices[name] ||= []
            choices[name] << value unless value.nil?
            choices[name]  += arrayize_arguments(args)
          else
            choices[name] = value
          end

        elsif (m = arg.match(/^(--[^=]+)=?/)) && longs.value?(m[1])
          # The joke here is we always accept both --long=VALUE and --long VALUE.
          
          # Grab values from --long=VALUE format
          name, value = arg.split('=', 2)
          name = longs.key(name)
          
          if value.nil? && args.first !~ /^-/
            # Grab value otherwise if not in --long=VALUE format.  Assume --long VALUE.
            # Value is nil if we don't have a = and the next argument is no good
            value = args.shift
          end

          # If we expect an array, tack this argument on.
          if arrayed[name]
            # If this is arrayed and the value isn't nil, set it.
            choices[name] ||= []
            choices[name] << value unless value.nil?
            choices[name] += arrayize_arguments(args)
          else
            # If we set the value to nil, that means nothing was set and we
            # need to set the value to true.  We'll find out later if that's 
            # acceptable or not.
            choices[name] = value.nil? ? true : value
          end

        else
          # If we're here, we have no idea what the passed argument is.  Die.
          if arg =~ /^-/
            raise UnknownOption 
          else
            rest << arg
          end
        end
      end

      # Okay, we got all the choices.  Now go through and run any filters or
      # whatever on them.
      choices.each do |name, value|
        # Check to make sure we have all the required arguments.
        raise ArgumentRequired if required[name] && value === true

        # Validate the argument if we need to, against a regexp or a block.
        if validators[name]
          if validators[name].is_a?(Regexp) && validators[name] =~ value 
          elsif validators[name].is_a?(Proc) && validators[name].call(value)
          else raise ArgumentValidationFails 
          end
        end

        # Make sure the argument is valid
        raise InvalidArgument unless Array(value).all? { |v| hashes['valids'][name].include?(v) } if hashes['valids'][name] 

        # Cast the argument using the method defined in the constant hash.
        value = value.send(CAST_METHODS[hashes['casts'][name]]) if hashes['casts'].include?(name)

        # Run the value through a filter and re-set it with the return.
        value = hashes['filters'][name].call(value) if hashes['filters'].include?(name)

        # Run an action block if there is one associated.
        hashes['actions'][name].call(value) if hashes['actions'].include?(name)
        
        # Now that we've done all that, re-set the element of the choice hash
        # with the (potentially) new value.
        if arrayed[name] && choices[name].empty?
          choices[name] = true
        else
          choices[name] = value
        end
      end
      
      # Die if we're missing any required arguments
      hard_required.each do |name, value|
        raise ArgumentRequired unless choices[name]
      end

      # Home stretch.  Go through all the defaults defined and if a choice
      # does not exist in our choices hash, set its value to the requested
      # default.
      hashes['defaults'].each do |name, value|
        choices[name] = value unless choices[name]
      end
      
      # Return the choices hash and the rest of the args
      [ choices, rest ]
    end

  private
    # Turns trailing command line arguments into an array for an arrayed value
    def arrayize_arguments(args)
      # Go through trailing arguments and suck them in if they don't seem
      # to have an owner.
      array = []
      until args.empty? || args.first.match(/^-/)
        array << args.shift
      end
      array
    end
    
    def make_validation(validation)
      case validation
        when Proc then
          validation
        when Regexp, String then 
          Regexp.new(validation.to_s)
        else 
          raise ValidateExpectsRegexpOrBlock
      end
    end
    
    # All the possible exceptions this module can raise.
    class ParseError < Exception; end
    class HashExpectedForOption < Exception; end
    class UnknownOption < ParseError; end      
    class ArgumentRequired < ParseError; end
    class ValidateExpectsRegexpOrBlock < ParseError; end
    class ArgumentValidationFails < ParseError; end
    class InvalidArgument < ParseError; end
    class ArgumentRequiredWithValid < ParseError; end
  end
end
