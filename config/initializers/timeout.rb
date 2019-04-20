# frozen_string_literal: true

# There is no request timeout mechanism inside of Puma. The Heroku router will
# timeout all requests that exceed 30 seconds. Although an error will be
# returned back to the client, Puma will continue to work on the request as
# there is no way for the router to notify Puma that the request terminated
# early. To avoid clogging processing ability, Rack::Timeout terminates long
# running requests.
if defined?(Rack::Timeout)
  Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout, service_timeout: 30
end
