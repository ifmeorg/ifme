# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require 'rack-rewrite'

use Rack::Rewrite do
  r301(/.*/, 'https://www.if-me.org$&', host: 'if-me.org')
end

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
