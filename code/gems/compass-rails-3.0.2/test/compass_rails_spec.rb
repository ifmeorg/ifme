require 'test_helper'

describe CompassRails do
  include CompassRails::Test::RailsHelpers

  it "compiles a basic compass stylesheet" do
    within_rails_app('test_railtie') do |project|
      project.setup_asset_fixtures!

      assert project.boots?

      project.precompile!

      project.compiled_stylesheet 'public/assets/application*.css' do |css|
        refute css.empty?
        assert_match 'body container', css
        assert_match "-webkit-linear-gradient", css
        assert_match "-moz-border-radius", css
        assert_match '.numbers-sprite-1', css
        assert_match '.numbers-sprite-2', css
        assert_match '.letters-a', css
        assert_match '.letters-a', css
      end
    end
  end

  it "supports rails config arguments" do
    within_rails_app('test_railtie') do |project|
      assert_equal "scss", project.rails_property("sass.preferred_syntax")
      assert_equal "public/assets", project.rails_property("compass.css_dir")

      project.set_rails('sass.preferred_syntax', :sass)
      project.set_rails('compass.css_dir', "public/stylesheets")

      assert_equal "sass", project.rails_property("sass.preferred_syntax")
      assert_equal "public/stylesheets", project.rails_property("compass.css_dir")
    end
  end unless ENV['DEBUG_COMPILE']

  it "compiles when in production mode" do
    within_rails_app('test_railtie') do |project|
      project.setup_asset_fixtures!

      # Mimic Rails production mode
      project.set_rails('assets.compile', false)

      assert project.boots?

      project.precompile!

      project.compiled_stylesheet 'public/assets/application*.css' do |css|
        refute css.empty?
        assert_match 'body container', css
        assert_match '.numbers-sprite-1', css
      end
    end
  end
end
