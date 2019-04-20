# frozen_string_literal: true

unless Rails.env.production?
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable = true
      Bullet.bullet_logger = true
    end
  end
end
