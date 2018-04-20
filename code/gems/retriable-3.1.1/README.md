# Retriable

[![Build Status](https://secure.travis-ci.org/kamui/retriable.svg)](http://travis-ci.org/kamui/retriable)
[![Code Climate](https://codeclimate.com/github/kamui/retriable/badges/gpa.svg)](https://codeclimate.com/github/kamui/retriable)
[![Test Coverage](https://codeclimate.com/github/kamui/retriable/badges/coverage.svg)](https://codeclimate.com/github/kamui/retriable)

Retriable is a simple DSL to retry failed code blocks with randomized [exponential backoff](http://en.wikipedia.org/wiki/Exponential_backoff) time intervals. This is especially useful when interacting external api/services or file system calls.

## Requirements

Ruby 2.0.0+

If you need ruby 1.9.3 support, use the [2.x branch](https://github.com/kamui/retriable/tree/2.x) by specifying `~2.1` in your Gemfile.

If you need ruby 1.8.x to 1.9.2 support, use the [1.x branch](https://github.com/kamui/retriable/tree/1.x) by specifying `~1.4` in your Gemfile.

## Installation

via command line:

```ruby
gem install retriable
```

In your ruby script:

```ruby
require 'retriable'
```

In your Gemfile:

```ruby
gem 'retriable', '~> 3.1'
```

## Usage

Code in a `Retriable.retriable` block will be retried if an exception is raised. By default, Retriable will rescue any exception inherited from `StandardError`, make 3 tries (including the initial attempt) before raising the last exception, and also use randomized exponential backoff to calculate each succeeding try interval. The default interval table with 10 tries looks like this (in seconds):

| retry#   | retry interval | randomized interval             |
| -------- | -------------- | ------------------------------- |
| 1        |    0.5         |  [0.25,   0.75]                 |
| 2        |    0.75        |  [0.375,  1.125]                |
| 3        |    1.125       |  [0.5625,  1.6875]              |
| 4        |    1.6875      |  [0.84375, 2.53125]             |
| 5        |    2.53125     |  [1.265625, 3.796875]           |
| 6        |    3.796875    |  [1.8984375,  5.6953125]        |
| 7        |    5.6953125   |  [2.84765625,  8.54296875]      |
| 8        |   8.54296875   |  [4.271484375, 12.814453125]    |
| 9        |  12.814453125  |  [6.4072265625, 19.2216796875]  |
| 10       | 19.2216796875  |  stop                           |

```ruby
require 'retriable'

class Api
  # Use it in methods that interact with unreliable services
  def get
    Retriable.retriable do
      # code here...
    end
  end
end
```

### Options

Here are the available options:

`tries` (default: 3) - Number of attempts to make at running your code block (includes intial attempt).

`base_interval` (default: 0.5) - The initial interval in seconds between tries.

`max_interval` (default: 60) - The maximum interval in seconds that any try can reach.

`rand_factor` (default: 0.25) - The percent range above and below the next interval is randomized between. The calculation is calculated like this:

```
randomized_interval = retry_interval * (random value in range [1 - randomization_factor, 1 + randomization_factor])
```

`multiplier` (default: 1.5) - Each successive interval grows by this factor. A multipler of 1.5 means the next interval will be 1.5x the current interval.

`max_elapsed_time`  (default: 900 (15 min)) - The maximum amount of total time that code is allowed to keep being retried.

`intervals`  (default: nil) - Skip generated intervals and provide your own array of intervals in seconds. Setting this option will ignore `tries`, `base_interval`, `max_interval`, `rand_factor`, and `multiplier` values.

`timeout` (default: nil) - Number of seconds to allow the code block to run before raising a `Timeout::Error` inside each try. Default is `nil` means the code block can run forever without raising error.

`on` (default: [StandardError]) - An `Array` of exceptions to rescue for each try, a `Hash` where the keys are `Exception` classes and the values can be a single `Regexp` pattern or a list of patterns, or a single `Exception` type. Subclasses of the listed exceptions will be retried and have their messages matched in the same way.

`on_retry` - (default: nil) - Proc to call after each try is rescued.

### Config

You can change the global defaults with a `#configure` block:

```ruby
Retriable.configure do |c|
  c.tries = 5
  c.max_elapsed_time = 3600 # 1 hour
end
```

### Examples

`Retriable.retriable` accepts custom arguments. This example will only retry on a `Timeout::Error`, retry 3 times and sleep for a full second before each try.

```ruby
Retriable.retriable on: Timeout::Error, tries: 3, base_interval: 1 do
  # code here...
end
```

You can also specify multiple errors to retry on by passing an array of exceptions.

```ruby
Retriable.retriable on: [Timeout::Error, Errno::ECONNRESET] do
  # code here...
end
```

You can also specify a Hash of exceptions where the values are a list or single Regexp pattern.

```ruby
Retriable.retriable on: {
  ActiveRecord::RecordNotUnique => nil,
  ActiveRecord::RecordInvalid => [/Email has already been taken/, /Username has already been taken/],
  Mysql2::Error => /Duplicate entry/
} do
  # code here...
end
```

You can also specify a timeout if you want the code block to only try for X amount of seconds. This timeout is per try.

```ruby
Retriable.retriable timeout: 60 do
  # code here...
end
```

If you need millisecond units of time for the sleep or the timeout:

```ruby
Retriable.retriable base_interval: (200/1000.0), timeout: (500/1000.0) do
  # code here...
end
```

### Custom Interval Array

You can also bypass the built-in interval generation and provide your own array of intervals. Supplying your own intervals overrides the `tries`, `base_interval`, `max_interval`, `rand_factor`, and `multiplier` parameters.

```ruby
Retriable.retriable intervals: [0.5, 1.0, 2.0, 2.5] do
  # code here...
end
```

This example makes 5 total attempts, if the first attempt fails, the 2nd attempt occurs 0.5 seconds later.

### Turn off Exponential Backoff

Exponential backoff is enabled by default, if you want to simply retry code every second, 5 times maximum, you can do this:

```ruby
Retriable.retriable tries: 5, base_interval: 1.0, multiplier: 1.0, rand_factor: 0.0 do
  # code here...
end
```

This works by starting at a 1 second interval (`base_interval`), setting the `multipler` to 1.0 means each subsequent try will increase 1x, which is still `1.0` seconds, and then a `rand_factor` of 0.0 means that there's no randomization of that interval. By default, it would randomize 0.25 seconds, which would mean normally the intervals would randomize between 0.75 and 1.25 seconds, but in this case `rand_factor` is basically being disabled.

Another way to accomplish this would be to create an array with a fixed interval. In this example, `Array.new(5, 1)` creates an array with 5 elements, all with the value 1. The code block will retry up to 5 times, and wait 1 second between each attempt.

```ruby
# Array.new(5, 1) # => [1, 1, 1, 1, 1]

Retriable.retriable intervals: Array.new(5, 1) do
  # code here...
end
```

If you don't want exponential backoff, but you still want some randomization between intervals, this code will run every 1 seconds with a randomization factor of 0.2, which means each interval will be a random value between 0.8 and 1.2 (1 second +/- 0.2):

```ruby
Retriable.retriable base_interval: 1.0, multiplier: 1.0, rand_factor: 0.2 do
  # code here...
end
```

### Callbacks

`#retriable` also provides a callback called `:on_retry` that will run after an exception is rescued. This callback provides the `exception` that was raised in the current try, the `try_number`, the `elapsed_time` for all tries so far, and the time in seconds of the `next_interval`. As these are specified in a `Proc`, unnecessary variables can be left out of the parameter list.

```ruby
do_this_on_each_retry = Proc.new do |exception, try, elapsed_time, next_interval|
  log "#{exception.class}: '#{exception.message}' - #{try} tries in #{elapsed_time} seconds and #{next_interval} seconds until the next try."
end

Retriable.retriable on_retry: do_this_on_each_retry do
  # code here...
end
```

### Ensure/Else

What if I want to execute a code block at the end, whether or not an exception was rescued ([ensure](http://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-ensure))? Or, what if I want to execute a code block if no exception is raised ([else](http://ruby-doc.org/docs/keywords/1.9/Object.html#method-i-else))? Instead of providing more callbacks, I recommend you just wrap retriable in a begin/retry/else/ensure block:

```ruby
begin
  Retriable.retriable do
    # some code
  end
rescue => e
  # run this if retriable ends up re-rasing the exception
else
  # run this if retriable doesn't raise any exceptions
ensure
  # run this no matter what, exception or no exception
end
```

## Contexts

Contexts allow you to coordinate sets of Retriable options across an application.  Each context is basically an argument hash for `Retriable.retriable` that is stored in the `Retriable.config` as a simple `Hash` and is accessible by name. For example:

```ruby
Retriable.configure do |c|
  c.contexts[:aws] = {
    tries: 3,
    base_interval: 5,
    on_retry: Proc.new { puts 'Curse you, AWS!' }
  }
  c.contexts[:mysql] = {
    tries: 10,
    multiplier: 2.5,
    on: Mysql::DeadlockException
  }
end
```

This will create two contexts, `aws` and `mysql`, which allow you to reuse different backoff strategies across your application without continually passing those strategy options to the `retriable` method.

These are used simply by calling `Retriable.with_context`:

```ruby
# Will retry all exceptions
Retriable.with_context(:aws) do
  # aws_call
end

# Will retry Mysql::DeadlockException
Retriable.with_context(:mysql) do
  # write_to_table
end
```

You can even temporarily override individual options for a configured context:

```ruby
Retriable.with_context(:mysql, tries: 30) do
  # write_to_table
end
```

## Kernel Extension

If you want to call `Retriable.retriable` without the `Retriable` module prefix and you don't mind extending `Kernel`,
there is a kernel extension available for this.

In your ruby script:

```ruby
require 'retriable/core_ext/kernel'
```

or in your Gemfile:

```ruby
gem 'retriable', require: 'retriable/core_ext/kernel'
```

and then you can call `#retriable` in any context like this:

```ruby
retriable do
  # code here...
end

retriable_with_context(:api) do
  # code here...
end
```

## Proxy Wrapper Object

[@julik](https://github.com/julik) has created a gem called [retriable_proxy](https://github.com/julik/retriable_proxy) that extends `retriable` with the ability to wrap objects and specify which methods you want to be retriable, like so:

```ruby
# api_endpoint is an instance of some kind of class that connects to an API
RetriableProxy.for_object(api_endpoint, on: Net::TimeoutError)
```

## Credits

The randomized exponential backoff implementation was inspired by the one used in Google's [google-http-java-client](https://code.google.com/p/google-http-java-client/wiki/ExponentialBackoff) project.
