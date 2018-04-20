# ResqueMailer
[![Gem Version](https://badge.fury.io/rb/resque_mailer.png)](http://badge.fury.io/rb/resque_mailer)
[![Build Status](https://secure.travis-ci.org/zapnap/resque_mailer.png)](http://travis-ci.org/zapnap/resque_mailer)

A gem plugin which allows messages prepared by ActionMailer to be delivered
asynchronously. Assumes you're using [Resque](https://github.com/resque/resque)
for your background jobs.

Note that recent (2.0+) versions of Resque::Mailer only work with Rails 3.x or 4.x.
For a version compatible with Rails 2, specify v1.x in your Gemfile.

## Installation

Install the gem:

    gem install resque_mailer

If you're using Bundler to manage your dependencies, you should add it to your Gemfile:

    gem 'resque' # or a compatible alternative / fork
    gem 'resque_mailer'

## Usage

Include Resque::Mailer in your ActionMailer subclass(es) like this:

```ruby
class MyMailer < ActionMailer::Base
  include Resque::Mailer
end
```

Now, when `MyMailer.subject_email(params).deliver` is called, an entry
will be created in the job queue. Your Resque workers will be able to deliver
this message for you. The queue we're using is imaginatively named `mailer`,
so just make sure your workers know about it and are loading your environment:

    QUEUE=mailer rake environment resque:work

Note that you can still have mail delivered synchronously by using the bang
method variant:

```ruby
MyMailer.subject_email(params).deliver!
```

Oh, by the way. Don't forget that **your async mailer jobs will be processed by
a separate worker**. This means that you should resist the temptation to pass
database-backed objects as parameters in your mailer and instead pass record
identifiers. Then, in your delivery method, you can look up the record from
the id and use it as needed. If you'd like, you can write your own serializer
to automate such things; see the section on serializers below.

If you want to set a different default queue name for your mailer, you can
change the `default_queue_name` property like so:

```ruby
# config/initializers/resque_mailer.rb
Resque::Mailer.default_queue_name = 'application_specific_mailer'
```

This is useful when you are running more than one application using
resque_mailer in a shared environment. You will need to use the new queue
name when starting your workers.

    QUEUE=application_specific_mailer rake environment resque:work

Custom handling of errors that arise when sending a message is possible by
assigning a lambda to the `error_handler` attribute. There are two supported
lambdas for backwards compatiability.

The first lamba will be deprecated in a future release:

```ruby
Resque::Mailer.error_handler = lambda { |mailer, message, error|
  # some custom error handling code here in which you optionally re-raise the error
}
```

The new lamba contains two other arguments, action and args, which allows
mailers to be requeued on failure:

```ruby
Resque::Mailer.error_handler = lambda { |mailer, message, error, action, args|
  # Necessary to re-enqueue jobs that receieve the SIGTERM signal
  if error.is_a?(Resque::TermException)
    Resque.enqueue(mailer, action, *args)
  else
    raise error
  end
}
```

### Resque::Mailer as a Project Default

If you have a variety of mailers in your application and want all of them to use
Resque::Mailer by default, you can subclass ActionMailer::Base and have your
other mailers inherit from an AsyncMailer:
```ruby
# config/initializers/resque_mailer.rb
class AsyncMailer < ActionMailer::Base
  include Resque::Mailer
end

# app/mailers/example_mailer.rb
class ExampleMailer < AsyncMailer
  def say_hello(user_id)
    # ...
  end
end
```

### Writing an Argument Serializer

By default, the arguments you pass to your mailer are passed as-is to Resque. This
means you cannot pass things like database-backed objects. If you'd like to write
your own serializer to enable such things, simply write a class that implements
the class methods `self.serialize(*args)` and `self.deserialize(data)` and set
`Resque::Mailer.argument_serializer = YourSerializerClass` in your resque_mailer
initializer.

There's also Active Record serializer which allows you to pass AR
models directly as arguments. To use it just do:
`Resque::Mailer.argument_serializer = Resque::Mailer::Serializers::ActiveRecordSerializer`

### Using with Resque Scheduler

If [resque-scheduler](https://github.com/bvandenbos/resque-scheduler) is
installed, two extra methods will be available: `deliver_at` and `deliver_in`.
These will enqueue mail for delivery at a specified time in the future.

```ruby
# Delivers on the 25th of December, 2014
MyMailer.reminder_email(params).deliver_at(Time.parse('2014-12-25'))

# Delivers in 7 days
MyMailer.reminder_email(params).deliver_in(7.days)

# Unschedule delivery
MyMailer.reminder_email(params).unschedule_delivery
```
## Testing

You don't want to be sending actual emails in the test environment, so you can
configure the environments that should be excluded like so:
```ruby
# config/initializers/resque_mailer.rb
Resque::Mailer.excluded_environments = [:test, :cucumber]
```

Note: Define `current_env` if using Resque::Mailer in a non-Rails project:
```ruby
Resque::Mailer.current_env = :production
```

## Note on Patches / Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Credits

Developed by Nick Plante with help from a number of [contributors](https://github.com/zapnap/resque_mailer/contributors).
