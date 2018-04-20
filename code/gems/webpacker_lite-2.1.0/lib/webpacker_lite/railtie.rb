require "rails/railtie"

require "webpacker_lite/helper"

class WebpackerLite::Engine < ::Rails::Engine
  initializer :webpacker_lite do |app|
    ActiveSupport.on_load :action_controller do
      ActionController::Base.helper WebpackerLite::Helper
    end

    ActiveSupport.on_load :action_view do
      include WebpackerLite::Helper
    end

    WebpackerLite.bootstrap
    Spring.after_fork {  WebpackerLite.bootstrap } if defined?(Spring)
  end
end
