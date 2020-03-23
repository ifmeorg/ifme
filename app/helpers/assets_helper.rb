# frozen_string_literal: true

# Adapted from https://gist.github.com/Dagnan/175168c456629a4ad1acdba8e0cdedb9
module AssetsHelper
  def inline_js(path)
    content = inline_file(path)
    return nil unless content

    "<script>#{content}</script>".html_safe
  end

  def inline_css(path)
    content = inline_file(path, true)
    return nil unless content

    "<style>#{content}</style>".html_safe
  end

  private

  def inline_file(path, css = false)
    if css && path == 'webpack_bundle.css'
      File.read(Rails.root.join('public', webpack_folder, path))
    elsif Rails.application.assets
      get_application_asset(path)
    else
      File.read(Rails.root.join('public', asset_path(path)))
    end
  end

  def webpack_folder
    Rails.env.test? ? 'webpack-test' : 'webpack'
  end

  def get_application_asset(path)
    asset = Rails.application.assets.find_asset(path)
    return nil unless asset

    asset.source
  end
end
