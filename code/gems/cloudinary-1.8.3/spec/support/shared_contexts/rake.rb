require "rake"

# From https://robots.thoughtbot.com/test-rake-tasks-like-a-boss
shared_context "rake" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/#{task_name.split(":").first}" }
  subject         { rake[task_name] }

  def loaded_files_excluding_current_rake_file
     $".reject {|file| file == Pathname.new(RSpec.project_root).join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [RSpec.project_root], loaded_files_excluding_current_rake_file)
    Rake::Task.define_task(:environment)
  end
end