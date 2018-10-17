unless Rails.env.production?
  Rails.application.configure do
    config.after_initialize do
      Bullet.enable = true
      Bullet.bullet_logger = true
      Bullet.console = true
      Bullet.rails_logger = true
    end
  end
end
