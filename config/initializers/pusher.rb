# config/initializers/pusher.rb
require 'pusher'

Pusher.app_id = '201720'
Pusher.key = '200b6370c503d11d4fa4'
Pusher.secret = 'e61d5c6887c8ecc6b134'
Pusher.logger = Rails.logger
Pusher.encrypted = true