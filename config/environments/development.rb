# frozen_string_literal: true

primary_domain = 'localhost:3000'

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

  # Enable/disable caching. By default caching is disabled.
  # config.consider_all_requests_local       = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = false

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  # config.assets.raise_runtime_errors = false

  # Suppress writing of asset requests to the log file
  config.assets.quiet = true

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: primary_domain }
  config.action_mailer.perform_deliveries = ENV['SEND_EMAIL']
  config.action_mailer.raise_delivery_errors = ENV['RAISE_DELIVERY_ERRORS']

  # To preview email in browser rather than to send a mail to actual user during development
  config.action_mailer.delivery_method = :letter_opener

  # If you want to actually test emails, you will have to configure SMTP settings in smtp.yml
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'],
    port: ENV['SMTP_PORT'],
    authentication: 'plain',
    user_name: ENV['SMTP_USER_NAME'],
    password: ENV['SMTP_PASSWORD'],
    domain: ENV['SMTP_DOMAIN'],
    enable_starttls_auto: true
  }

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.force_ssl = false

  config.action_controller.default_url_options = { host: primary_domain }
  config.action_controller.asset_host = primary_domain
end
