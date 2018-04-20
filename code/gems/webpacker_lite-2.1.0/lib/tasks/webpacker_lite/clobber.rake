require "webpacker_lite/configuration"

namespace :webpacker_lite do
  desc "Remove the webpack compiled output directory as defined in config/webpack/paths.yml"
  task clobber: ["webpacker_lite:verify_install", :environment] do
    output_path = WebpackerLite::Configuration.webpack_public_output_dir
    FileUtils.rm_r(output_path) if File.exist?(output_path)
    puts "Removed webpack output path directory #{output_path}"
  end
end

# Run clobber if the assets:clobber is run
if Rake::Task.task_defined?("assets:clobber")
  Rake::Task["assets:clobber"].enhance do
    Rake::Task["webpacker_lite:clobber"].invoke
  end
end
