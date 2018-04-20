if defined?(::Rails)
  if CompassRails.rails31? || CompassRails.rails32?
    require "compass-rails/railties/3_1"
  else
    require "compass-rails/railties/4_0"
  end
end
