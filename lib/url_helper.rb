# frozen_string_literal: true

# Helper to be included to create urls
module UrlHelper
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  included do
    delegate :default_url_options, to: :'ActionMailer::Base'
  end
end
