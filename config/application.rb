require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ifme
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.active_record.raise_in_transactional_callbacks = true

    config.exceptions_app = self.routes

    config.autoload_paths << Rails.root.join('lib')

    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
        if html_tag.to_str.include?("label")
            "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe
        else
            "#{html_tag}".html_safe
        end
    }

    # export translations for use in javascript
    config.middleware.use I18n::JS::Middleware

    config.i18n.available_locales = [:en, :es]
    config.i18n.default_locale = :en
  end
end
