# frozen_string_literal: true

require_relative "boot"
require_relative "locale"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ifme
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

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

    config.action_view.sanitized_allowed_tags = Rails::Html::Sanitizer.white_list_sanitizer.allowed_tags + ['strike', 'u']

    config.to_prepare do
      Devise::Mailer.layout 'mailer'
    end
  end
end
