# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ifme
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[
    #   Rails.root.join('my', 'locales', '*.{rb,yml}').to_s
    # ]

    config.exceptions_app = routes

    config.autoload_paths << Rails.root.join('lib')

    config.action_view.field_error_proc = proc { |html_tag|
      if html_tag.to_s.include?('label')
        %(<div class="errorField">#{html_tag}</div>).html_safe
      else
        html_tag.to_s.html_safe
      end
    }

    # gzip the html/json responses
    config.middleware.use Rack::Deflater, include: %w[text/html application/json image/svg+xml]
    # export translations for use in javascript
    config.middleware.use I18n::JS::Middleware

    config.i18n.available_locales = ['pt-BR'].concat %i[en es sv nl it nb vi]

    config.i18n.default_locale = :en

    config.secret_share_enabled = false
  end
end
