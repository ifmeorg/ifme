# frozen_string_literal: true

require_relative 'boot'
require_relative 'locale'
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

    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'SAMEORIGIN',
      'X-XSS-Protection' => '1; mode=block',
      'X-Content-Type-Options' => 'nosniff',
      'X-Download-Options' => 'noopen',
      'X-Permitted-Cross-Domain-Policies' => 'none',
      'Referrer-Policy' => 'strict-origin-when-cross-origin',
      'Strict-Transport-Security' => 'max-age=31536000'
    }

    config.middleware.use Rack::Deflater,
      include: %w[text/html application/json image/svg+xml]

    config.i18n.available_locales = Locale.available_locales.sort_by(&:swapcase).map &:to_sym
    config.i18n.default_locale = :en
  end
end
