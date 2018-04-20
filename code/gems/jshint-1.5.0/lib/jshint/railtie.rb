require 'jshint'
require 'rails'

module Jshint

  # A way to hook in to Rails to load our custom lint Rake task
  class Railtie < Rails::Railtie
    rake_tasks do
      load "jshint/tasks/jshint.rake"
    end
  end
end
