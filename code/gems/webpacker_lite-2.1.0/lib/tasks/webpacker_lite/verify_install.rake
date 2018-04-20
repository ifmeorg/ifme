require "webpacker_lite/configuration"

namespace :webpacker_lite do
  desc "Verifies if webpacker_lite is installed"
  task verify_install: [:check_node, :check_yarn] do
    if File.exist?(WebpackerLite::Env.file_path)
      puts "WebpackerLite is installed 🎉 🍰"
      puts "Using #{WebpackerLite::Env.file_path} file for setting up webpack paths"
    else
      puts "Configuration config/webpack/paths.yml file not found. \n"\
           "Make sure webpacker_lite:install is run successfully before " \
           "running dependent tasks"
      exit!
    end
  end
end
