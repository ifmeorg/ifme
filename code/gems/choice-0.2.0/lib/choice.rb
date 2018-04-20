$:.unshift File.dirname(__FILE__)
require 'choice/option'
require 'choice/parser'
require 'choice/writer'
require 'choice/lazyhash'

#
# Usage of this module is lovingly detailed in the README file.
#
module Choice
  extend self

  # The main method, which defines the options
  def options(hash = {}, &block)
    # if we are passing in a hash to define our options, use that straight
    options_from_hash(hash) unless hash.empty?

    # Setup all instance variables
    reset! if hash.empty?
    @@args ||= ARGV

    # Eval the passed block to define the options.
    instance_eval(&block) if block_given?

    # Parse what we've got.
    parse unless parsed?
  end

  # Set options from a hash, shorthand style
  def options_from_hash(options_hash)
    options_hash.each do |name, definition|
      option = Option.new
      definition.each do |key, value|
        Array(value).each { |hit| option.send(key, hit) }
      end
      @@options << [name.to_s, option]
    end
  end

  # Return an array representing the rest of the command line arguments
  def rest
    @@rest
  end

  # Returns a hash representing options passed in via the command line.
  def choices
    @@choices
  end

  # Shortcut access to Choice.choices
  def [](choice)
    choices[choice]
  end

  # Defines an option.
  def option(opt, options = {}, &block)
    # Notice: options is maintained as an array of arrays, the first element
    # the option name and the second the option object.
    @@options << [opt.to_s, Option.new(options, &block)]
  end

  # Separators are text displayed by --help within the options block.
  def separator(str)
    # We store separators as simple strings in the options array to maintain
    # order.  They are ignored by the parser.
    @@options << str
  end

  # Define the banner, header, footer methods.  All are just getters/setters
  # of class variables.
  %w[banner header footer].each do |method|
    define_method(method) do |string=nil|
      variable = "@@#{method}"
      return class_variable_get(variable) if string.nil?
      val = class_variable_get(variable) || ''
      class_variable_set(variable, val << string)
    end
  end

  # Parse the provided args against the defined options.
  def parse #:nodoc:
    # Do nothing if options are not defined.
    return unless @@options.size > 0

    # Show help if it's anywhere in the argument list.
    if @@args.include?('--help')
      help
    else
      begin
        # Delegate parsing to our parser class, passing it our defined
        # options and the passed arguments.
        @@choices, @@rest = Parser.parse(@@options, @@args)
        @@choices = LazyHash.new(@@choices)
      rescue Choice::Parser::ParseError
        # If we get an expected exception, show the help file.
        help
      end
    end
  end

  # Did we already parse the arguments?
  def parsed? #:nodoc:
    @@choices ||= false
  end

  # Print the help screen by calling our Writer object
  def help #:nodoc:
    Writer.help( { :banner => @@banner, :header => @@header,
                   :options => @@options, :footer => @@footer },
                   output_to, exit_on_help? )
  end

  # Set the args, potentially to something other than ARGV.
  def args=(args) #:nodoc:
    @@args = args.dup.map { |a| a + '' }
    parse if parsed?
  end

  # Return the args.
  def args #:nodoc:
    @@args
  end

  # Returns the arguments that follow an argument
  def args_of(opt)
    args_of_opt = []

    # Return an array of the arguments between opt and the next option,
    # which all start with "-"
    @@args.slice(@@args.index(opt)+1, @@args.length).select do |arg|
      if arg[0].chr != "-"
        args_of_opt << arg
      else
        break
      end
    end
    args_of_opt
  end

  # You can choose to not kill the script after the help screen is printed.
  def dont_exit_on_help=(val) #:nodoc:
    @@exit = true
  end

  # Do we want to exit on help?
  def exit_on_help? #:nodoc:
    @@exit rescue false
  end

  # If we want to write to somewhere other than STDOUT.
  def output_to(target = nil) #:nodoc:
    @@output_to ||= STDOUT
    return @@output_to if target.nil?
    @@output_to = target
  end

  # Reset all the class variables.
  def reset! #:nodoc:
    @@args    = false
    @@banner  = false
    @@header  = Array.new
    @@options = Array.new
    @@footer  = Array.new
  end
end
