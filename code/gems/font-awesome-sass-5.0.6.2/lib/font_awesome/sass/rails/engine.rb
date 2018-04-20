module FontAwesome
  module Sass
    module Rails
      class Engine < ::Rails::Engine
        initializer 'font-awesome-sass.assets.precompile', group: :all do |app|
          %w[stylesheets fonts].each do |sub|
            app.config.assets.paths << root.join('assets', sub).to_s
          end

          %w[eot svg ttf woff woff2].each do |ext|
            app.config.assets.precompile << "font-awesome/fa-brands-400.#{ext}"
            app.config.assets.precompile << "font-awesome/fa-regular-400.#{ext}"
            app.config.assets.precompile << "font-awesome/fa-solid-900.#{ext}"
          end
        end
      end
    end
  end
end
