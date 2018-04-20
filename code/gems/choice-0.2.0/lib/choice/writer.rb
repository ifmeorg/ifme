module Choice
  # This module writes to the screen.  As of now, its only real use is writing
  # the help screen.
  module Writer #:nodoc: all
    
    # Some constants used for printing and line widths
    SHORT_LENGTH = 6
    SHORT_BREAK_LENGTH = 2 
    LONG_LENGTH = 29
    PRE_DESC_LENGTH = SHORT_LENGTH + SHORT_BREAK_LENGTH + LONG_LENGTH
    
    
    # The main method.  Takes a hash of arguments with the following possible
    # keys, running them through the appropriate method:
    #  banner, header, options, footer
    #
    # Can also be told where to print (default STDOUT) and not to exit after
    # printing the help screen, which it does by default.
    def self.help(args, target = STDOUT, dont_exit = false)
      # Set our printing target.
      self.target = target

      # The banner method needs to know about the passed options if it's going
      # to do its magic.  Only really needs :options if :banner is nil.
      banner(args[:banner], args[:options])

      # Run these three methods, passing in the appropriate hash element.
      %w[header options footer].each do |meth|
        send(meth, args[meth.to_sym])
      end

      # Exit.  Unless you don't want to.
      exit unless dont_exit
    end

    class <<self
      private
      
      # Print a passed banner or assemble the default banner, which is usage.
      def banner(banner, options)
        if banner
          puts banner
        else
          # Usage needs to know about the defined options.
          usage(options)
        end
      end
      
      # Print our header, which is just lines after the banner and before the
      # options block.  Needs an array, prints each element as a line.
      def header(header)
        if header.is_a?(Array) and header.size > 0
          header.each { |line| puts line }
        end
      end

      # Print out the options block by going through each option and printing
      # it as a line (or more).  Expects an array.
      def options(options)
        # Do nothing if there's nothing to do.
        return if options.nil? || !options.size
        
        # If the option is a hash, run it through option_line.  Otherwise
        # just print it out as is.
        options.each do |name, option|
          if !option.nil? && option.respond_to?(:to_h)
            option_line(option.to_h)          
          else
            puts name
          end
        end
      end
      
      # The heavy lifting: print a line for an option.  Has intimate knowledge
      # of what keys are expected.
      def option_line(option)
        # Expect a hash
        return unless option.is_a?(Hash)

        # Make this easier on us
        short = option['short']
        long = option['long']
        line = ''

        # Get the short part.
        line << sprintf("%#{SHORT_LENGTH}s", short)
        line << sprintf("%-#{SHORT_BREAK_LENGTH}s", (',' if short && long))

        # Get the long part.
        line << sprintf("%-#{LONG_LENGTH}s", long)

        # Print what we have so far
        print line

        # If there's a desc, print it.
        if option['desc']
          # If the line is too long, spill over to the next line
          if line.length > PRE_DESC_LENGTH
            puts           
            print " " * PRE_DESC_LENGTH
          end

          puts option['desc'].shift
          
          # If there is more than one desc line, print each one in succession
          # as separate lines.
          option['desc'].each do |desc| 
            puts ' '*37 + desc
          end

        else
          # No desc, just print a newline.
          puts 

        end
      end
      
      # Expects an array, prints each element as a line.
      def footer(footer)
        footer.each { |line| puts line } unless footer.nil?
      end
      
      # Prints the usage statement, e.g. Usage prog.rb [-abc]
      # Expects an array.
      def usage(options)
        # Really we just need an enumerable.
        return unless options.respond_to?(:each)

        # Start off the options with a dash.
        opts = '-'

        # Figure out the option shorts.
        options.dup.each do |option|
          # We really need an array here.
          next unless option.is_a?(Array)

          # Grab the hash of the last element, which should be the second 
          # element.
          option = option.last.to_h

          # Add the short to the options string.
          opts << option['short'].sub('-','') if option['short']
        end
        
        # Figure out if we actually got any options.
        opts = if opts =~ /^-(.+)/
                 " [#{opts}]"
               end.to_s
        
        # Print it out, with our newly aquired options string.
        puts "Usage: #{program}" << opts
      end

      # Figure out the name of this program based on what was run.
      def program
        (/(\/|\\)/ =~ $0) ? File.basename($0) : $0
      end

      # Set where we print.
      def target=(target)
        @@target = target
      end
      
      # Where do we print?
      def target
        @@target
      end

      public
      # Fake puts
      def puts(str = nil)
        str = '' if str.nil?
        print(str + "\n")
      end
      
      # Fake printf
      def printf(format, *args)
        print(sprintf(format, *args))
      end

      # Fake print -- just add to target, which may not be STDOUT.
      def print(str)
        target << str 
      end
    end
  end
end
