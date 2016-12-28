Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # reroute all requests with errors to the views/layouts/errors.html.erb page
  config.consider_all_requests_local = false

  # Show full error reports and disable caching.
  # config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.perform_deliveries = ENV["SEND_EMAIL"]
  config.action_mailer.raise_delivery_errors = ENV["RAISE_DELIVERY_ERRORS"]

  # To preview email in browser rather than to send a mail to actual user during development
  config.action_mailer.delivery_method = :letter_opener

  # If you want to actually test emails, you will have to configure SMTP settings in smtp.yml
  config.action_mailer.smtp_settings = {
    address: ENV["SMTP_ADDRESS"],
    port: ENV["SMTP_PORT"],
    authentication: "plain",
    user_name: ENV["SMTP_USER_NAME"],
    password: ENV["SMTP_PASSWORD"],
    domain: ENV["SMTP_DOMAIN"],
    enable_starttls_auto: true
  }

  config.force_ssl = false
end
