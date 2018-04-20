module Helpers
  module TempFileHelpers
    def clean_up_temp_files!
      FileUtils.remove_entry temp_root
    end

    def temp_root
      @temp_root ||= Dir.mktmpdir 'test_root'
    end

    def copy_root_to_temp(source)
      source = File.join(RSpec.project_root, source) unless Pathname.new(source).directory?
      FileUtils.copy_entry source, temp_root
    end

    def copy_file_to_temp(source, dest)
      dest_path = File.join(temp_root, dest)
      FileUtils.mkdir_p(File.dirname(dest_path))
      FileUtils.copy_entry(File.join(RSpec.project_root, source), dest_path)
    end
  end
end
