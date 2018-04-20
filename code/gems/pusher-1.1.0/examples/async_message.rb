require 'rubygems'
require 'pusher'
require 'eventmachine'
require 'em-http-request'

# To get these values:
# - Go to https://app.pusherapp.com/
# - Click on Choose App.
# - Click on one of your apps
# - Click API Access
Pusher.app_id = 'your_app_id'
Pusher.key = 'your_key'
Pusher.secret = 'your_secret'


EM.run {
  deferrable = Pusher['test_channel'].trigger_async('my_event', 'hi')

  deferrable.callback { # called on success
    puts "Message sent successfully."
    EM.stop
  }
  deferrable.errback { |error| # called on error
    puts "Message could not be sent."
    puts error
    EM.stop
  }
}
