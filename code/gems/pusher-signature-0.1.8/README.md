pusher-signature
=========

[![Build Status](https://secure.travis-ci.org/pusher/pusher-signature.png?branch=master)](http://travis-ci.org/pusher/pusher-signature)

This gem is a fork of the [signature](https://github.com/mloughran/signature) gem, written by [Martyn Loughran](https://github.com/mloughran). It has now been released as a separate gem to resolve namespace collisions.

Examples
--------

Client example

```ruby
params       = {:some => 'parameters'}
token        = Pusher::Signature::Token.new('my_key', 'my_secret')
request      = Pusher::Signature::Request.new('POST', '/api/thing', params)
auth_hash    = request.sign(token)
query_params = params.merge(auth_hash)

HTTParty.post('http://myservice/api/thing', {
  :body => query_params
})
```

`query_params` looks like:

```ruby
{
  :some           => "parameters",
  :auth_timestamp => 1273231888,
  :auth_signature => "28b6bb0f242f71064916fad6ae463fe91f5adc302222dfc02c348ae1941eaf80",
  :auth_version   => "1.0",
  :auth_key       => "my_key"
}

```
Server example (sinatra)

```ruby
error Pusher::Signature::AuthenticationError do |controller|
  error = controller.env["sinatra.error"]
  halt 401, "401 UNAUTHORIZED: #{error.message}\n"
end

post '/api/thing' do
  request = Pusher::Signature::Request.new('POST', env["REQUEST_PATH"], params)
  # This will raise a Signature::AuthenticationError if request does not authenticate
  token = request.authenticate do |key|
    Pusher::Signature::Token.new(key, lookup_secret(key))
  end

  # Do whatever you need to do
end
```

Developing
----------

    bundle
    bundle exec rspec spec/*_spec.rb

Please see the travis status for a list of rubies tested against

Copyright
---------

Copyright (c) 2010 Martyn Loughran, 2015 Pusher Ltd. See LICENSE for details.
