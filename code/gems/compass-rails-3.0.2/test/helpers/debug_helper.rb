module CompassRails
  module Test
    module DebugHelper

      def debug(message)
       puts "#{message}\n" if ENV['DEBUG']
       $stdout.flush
      end

    end
  end
end
