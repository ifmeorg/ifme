# frozen_string_literal: true

# Helper to be included to create urls
module UrlHelper
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  included do
    def default_url_options
      ActionMailer::Base.default_url_options
    end
  end
end
