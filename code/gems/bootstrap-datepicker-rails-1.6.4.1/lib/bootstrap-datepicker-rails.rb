require "rails"
require "bootstrap-datepicker-rails/version"

module BootstrapDatepickerRails
  module Rails
    if ::Rails.version.to_s < "3.1"
      require "bootstrap-datepicker-rails/railtie"
    else
      require "bootstrap-datepicker-rails/engine"
    end
  end
end
