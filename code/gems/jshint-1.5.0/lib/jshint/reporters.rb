# Top level namespace capable of containing different lint reporting classes
module Jshint::Reporters
  autoload :Default, 'jshint/reporters/default'
  autoload :Junit, 'jshint/reporters/junit'
end
