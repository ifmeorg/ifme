require 'date'

Gem::Specification.new do |s|
  s.name = 'rack-rewrite'
  s.version = File.read('VERSION')

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Travis Jeffery", "John Trupiano"]
  s.date = Date.today.to_s
  s.description = %q{A rack middleware for enforcing rewrite rules. In many cases you can get away with rack-rewrite instead of writing Apache mod_rewrite rules.}
  s.email = %q{travisjeffery@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "History.rdoc",
  ]
  s.files = [
    "History.rdoc",
    "LICENSE",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "Gemfile",
    "lib/rack-rewrite.rb",
    "lib/rack/rewrite.rb",
    "lib/rack/rewrite/rule.rb",
    "lib/rack/rewrite/version.rb",
    "rack-rewrite.gemspec",
    "test/geminstaller.yml",
    "test/rack-rewrite_test.rb",
    "test/rule_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/jtrupiano/rack-rewrite}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{johntrupiano}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A rack middleware for enforcing rewrite rules}
  s.test_files = [
    "test/rack-rewrite_test.rb",
    "test/geminstaller.yml",
    "test/rack-rewrite_test.rb",
    "test/rule_test.rb",
    "test/test_helper.rb"
  ]

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'shoulda', '~> 2.10.2'
  s.add_development_dependency 'mocha', '~> 0.9.7'
  s.add_development_dependency 'rack'

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end
end

