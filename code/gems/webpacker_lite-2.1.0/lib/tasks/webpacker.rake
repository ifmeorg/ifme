tasks = {
  "webpacker_lite:clobber" => "Remove the webpack compiled output directory as defined in config/webpack/paths.yml",
  "webpacker_lite:check_node"      => "Verifies if Node.js is installed",
  "webpacker_lite:check_yarn"      => "Verifies if yarn is installed",
  "webpacker_lite:verify_install"  => "Verifies if webpacker is installed"
}.freeze

desc "Lists all available tasks in webpacker_lite"
task :webpacker_lite do
  puts "Available webpacker_lite tasks are:"
  tasks.each { |task, message| puts task.ljust(30) + message }
end
