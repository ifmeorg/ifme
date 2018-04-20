module CompassRails
  module Test
    module FileHelper
      include DebugHelper

      delegate :mkdir_p, :rm, :rm_rf, :cp_r, :touch, to: ::FileUtils

      def cd(path, &block)
        debug "Entering: #{path}"
        Dir.chdir(path, &block)
      end

      def inject_at_bottom(file_name, string)
        content = File.read(file_name)
        content = "#{content}#{string}"
        File.open(file_name, 'w') { |file| file << content }
      end

      def inject_into_file(file_name, replacement, position, anchor)
        case position
        when :after
          replace(file_name, Regexp.escape(anchor), "#{anchor}#{replacement}")
        when :before
          replace(file_name, Regexp.escape(anchor), "#{replacement}#{anchor}")
        else
          raise Compass::FilesystemConflict.new("You need to specify :before or :after")
        end
      end

      def replace(destination, regexp, string)
        content = File.read(destination)
        content.gsub!(Regexp.new(regexp), string)
        File.open(destination, 'wb') { |file| file.write(content) }
      end

    end
  end
end
