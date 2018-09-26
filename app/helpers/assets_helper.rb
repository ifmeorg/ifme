# frozen_string_literal: true

# Adapted from https://gist.github.com/Dagnan/175168c456629a4ad1acdba8e0cdedb9
module AssetsHelper
  def inline_js(path)
    content = inline_file(path)
    return nil unless content

    "<script>#{content}</script>".html_safe
  end

  def inline_css(path)
    content = inline_file(path)
    return nil unless content

    "<style>#{content}</style>".html_safe
  end

  private

  def inline_file(path)
    if Rails.application.assets
      asset = Rails.application.assets.find_asset(path)
      return nil unless asset

      asset.source
    else
      File.read(Rails.root.join('public', asset_path(path)))
    end
  end
end
