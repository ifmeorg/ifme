Pusher gem
==========

[![Build Status](https://secure.travis-ci.org/pusher/pusher-http-ruby.svg?branch=master)](http://travis-ci.org/pusher/pusher-http-ruby)

## Installation & Configuration

Add pusher to your Gemfile, and then run `bundle install`

``` ruby
gem 'pusher'
```

or install via gem

``` bash
gem install pusher
```

After registering at <http://pusher.com> configure your app with the security credentials.

### Instantiating a Pusher client

Creating a new Pusher `client` can be done as follows.

``` ruby
pusher_client = Pusher::Client.new(
  app_id: 'your-pusher-app-id',
  key: 'your-pusher-key',
  secret: 'your-pusher-secret'
)
```

If you want to set a custom `host` value for your client then you can do so when instantiating a Pusher client like so:

``` ruby
pusher_client = Pusher::Client.new(
  app_id: 'your-pusher-app-id',
  key: 'your-pusher-key',
  secret: 'your-pusher-secret',
  host: 'your-pusher-host'
)
```

If you created your app in a different cluster to the default cluster, you must pass the `cluster` option as follows:

``` ruby
pusher_client = Pusher::Client.new(
  app_id: 'your-pusher-app-id',
  key: 'your-pusher-key',
  secret: 'your-pusher-secret',
  cluster: 'your-app-cluster'
)
```

This will set the `host` to `api-<cluster>.pusher.com`. If you pass both `host` and `cluster` options, the `host` will take precendence and `cluster` will be ignored.

Finally, if you have the configuration set in an `PUSHER_URL` environment
variable, you can use:

``` ruby
pusher_client = Pusher::Client.from_env
```

### Global

Configuring Pusher can also be done globally on the Pusher class.

``` ruby
Pusher.app_id = 'your-pusher-app-id'
Pusher.key = 'your-pusher-key'
Pusher.secret = 'your-pusher-secret'
```

Global configuration will automatically be set from the `PUSHER_URL` environment variable if it exists. This should be in the form  `http://KEY:SECRET@api.pusherapp.com/apps/APP_ID`. On Heroku this environment variable will already be set.

If you need to make requests via a HTTP proxy then it can be configured

``` ruby
Pusher.http_proxy = 'http://(user):(password)@(host):(port)'
```

By default API requests are made over HTTP. HTTPS can be used by setting

``` ruby
Pusher.encrypted = true
```

As of version 0.12, SSL certificates are verified when using the synchronous http client. If you need to disable this behaviour for any reason use:

``` ruby
Pusher.default_client.sync_http_client.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
```

## Interacting with the Pusher service

The Pusher gem contains a number of helpers for interacting with the service. As a general rule, the library adheres to a set of conventions that we have aimed to make universal.

### Handling errors

Handle errors by rescuing `Pusher::Error` (all errors are descendants of this error)

``` ruby
begin
  Pusher.trigger('a_channel', 'an_event', :some => 'data')
rescue Pusher::Error => e
  # (Pusher::AuthenticationError, Pusher::HTTPError, or Pusher::Error)
end
```

### Logging

Errors are logged to `Pusher.logger`. It will by default log at info level to STDOUT using `Logger` from the standard library, however you can assign any logger:

``` ruby
Pusher.logger = Rails.logger
```

### Publishing events

An event can be published to one or more channels (limited to 10) in one API call:

``` ruby
Pusher.trigger('channel', 'event', foo: 'bar')
Pusher.trigger(['channel_1', 'channel_2'], 'event_name', foo: 'bar')
```

An optional fourth argument may be used to send additional parameters to the API, for example to [exclude a single connection from receiving the event](http://pusher.com/docs/publisher_api_guide/publisher_excluding_recipients).

``` ruby
Pusher.trigger('channel', 'event', {foo: 'bar'}, {socket_id: '123.456'})
```

#### Batches

It's also possible to send multiple events with a single API call (max 10
events per call on multi-tenant clusters):

``` ruby
Pusher.trigger_batch([
  {channel: 'channel_1', name: 'event_name', data: { foo: 'bar' }}
  {channel: 'channel_1', name: 'event_name', data: { hello: 'world' }}
])
```

#### Deprecated publisher API

Most examples and documentation will refer to the following syntax for triggering an event:

``` ruby
Pusher['a_channel'].trigger('an_event', :some => 'data')
```

This will continue to work, but has been replaced by `Pusher.trigger` which supports one or multiple channels.

### Using the Pusher REST API

This gem provides methods for accessing information from the [Pusher REST API](https://pusher.com/docs/rest_api). The documentation also shows an example of the responses from each of the API endpionts.

The following methods are provided by the gem.

- `Pusher.channel_info('channel_name')` returns information about that channel.

- `Pusher.channel_users('channel_name')` returns a list of all the users subscribed to the channel.

- `Pusher.channels` returns information about all the channels in your Pusher application.

### Asynchronous requests

There are two main reasons for using the `_async` methods:

* In a web application where the response from Pusher is not used, but you'd like to avoid a blocking call in the request-response cycle
* Your application is running in an event loop and you need to avoid blocking the reactor

Asynchronous calls are supported either by using an event loop (eventmachine, preferred), or via a thread.

The following methods are available (in each case the calling interface matches the non-async version):

* `Pusher.get_async`
* `Pusher.post_async`
* `Pusher.trigger_async`

It is of course also possible to make calls to pusher via a job queue. This approach is recommended if you're sending a large number of events to pusher.

#### With eventmachine

* Add the `em-http-request` gem to your Gemfile (it's not a gem dependency).
* Run the eventmachine reactor (either using `EM.run` or by running inside an evented server such as Thin).

The `_async` methods return an `EM::Deferrable` which you can bind callbacks to:

``` ruby
Pusher.get_async("/channels").callback { |response|
  # use reponse[:channels]
}.errback { |error|
  # error is an instance of Pusher::Error
}
```

A HTTP error or an error response from pusher will cause the errback to be called with an appropriate error object.

#### Without eventmachine

If the eventmachine reactor is not running, async requests will be made using threads (managed by the httpclient gem).

An `HTTPClient::Connection` object is returned immediately which can be [interrogated](http://rubydoc.info/gems/httpclient/HTTPClient/Connection) to discover the status of the request. The usual response checking and processing is not done when the request completes, and frankly this method is most useful when you're not interested in waiting for the response.


## Authenticating subscription requests

It's possible to use the gem to authenticate subscription requests to private or presence channels. The `authenticate` method is available on a channel object for this purpose and returns a JSON object that can be returned to the client that made the request. More information on this authentication scheme can be found in the docs on <http://pusher.com>

### Private channels

``` ruby
Pusher.authenticate('private-my_channel', params[:socket_id])
```

### Presence channels

These work in a very similar way, but require a unique identifier for the user being authenticated, and optionally some attributes that are provided to clients via presence events:

``` ruby
Pusher.authenticate('presence-my_channel', params[:socket_id],
  user_id: 'user_id',
  user_info: {} # optional
)
```

## Receiving WebHooks

A WebHook object may be created to validate received WebHooks against your app credentials, and to extract events. It should be created with the `Rack::Request` object (available as `request` in Rails controllers or Sinatra handlers for example).

``` ruby
webhook = Pusher.webhook(request)
if webhook.valid?
  webhook.events.each do |event|
    case event["name"]
    when 'channel_occupied'
      puts "Channel occupied: #{event["channel"]}"
    when 'channel_vacated'
      puts "Channel vacated: #{event["channel"]}"
    end
  end
  render text: 'ok'
else
  render text: 'invalid', status: 401
end
```
