# JSHint

[![travis-ci](https://api.travis-ci.org/damian/jshint.png)](http://travis-ci.org/#!/damian/jshint)
[![Code Climate](https://codeclimate.com/github/damian/jshint.png)](https://codeclimate.com/github/damian/jshint)
[![Coverage Status](https://coveralls.io/repos/damian/jshint/badge.png?branch=master)](https://coveralls.io/r/damian/jshint?branch=master)

Making it easy to lint your JavaScript assets in any Rails 3.1+ application.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
group :development, :test do
  gem 'jshint'
end
```

And then execute:

```ruby
$ bundle
```

Run the generator:

```ruby
bundle exec rake jshint:install_config
```

## Usage

To start using JSHint simply run the Rake task:

```ruby
bundle exec rake jshint
```

This Rake task runs JSHint across any JavaScript files contained within the following three folders in your Rails application to ensure that they're lint free. Using that data it builds a report which is shown in STDOUT.

```bash
your-rails-project/app/assets/javascripts
your-rails-project/vendor/assets/javascripts
your-rails-project/lib/assets/javascripts
```

## Configuration

JSHint has some configuration options. You can read the default configuration created by JSHint in `config/jshint.yml` within your application.

```yaml
# your-rails-project/config/jshint.yml
files: ['**/*.js']
exclude_paths: []
exclude_files: []
options:
  boss: true
  browser: true
  ...
  globals:
    jQuery: true
    $: true
```
For more configuration options see the [JSHint documentation](http://jshint.com/docs/options/).

### Custom configuration

You can specify an other path to your configuration file via:

```ruby
bundle exec rake jshint:lint['path/to/your/config.yml']
```

### Including folders to be Linted

To add folders outside of the standard Rails asset paths, you can define an array of `include_paths` within your configuration file.

````yaml
files: ['**/*.js']
include_paths: ['spec/javascripts']
...
````

### Excluding folders from being Linted

To exclude a folder from being linted you can define an array of `exclude_paths` within your configuration file.

````yaml
files: ['**/*.js']
exclude_paths: ['vendor', 'app/assets/javascripts/tests/']
...
````

### Excluding files from being Linted

To exclude a file from being linted you can define an array of `exclude_files` within your configuration file.

````yaml
files: ['**/*.js']
exclude_files: ['**/*test.js']
...
````

## Rake integration
To use jshint in your default Rake config, just add it to the list of default tasks. For example, this configuration will run jshint in development or test environments.
````ruby
# your-rails-project/Rakefile
if %w(development test).include? Rails.env
  task default: :jshint
end
````

## Changelog

You can view the [changelog here](https://github.com/damian/jshint/blob/master/CHANGELOG.md).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
