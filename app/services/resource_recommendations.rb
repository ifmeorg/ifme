# frozen_string_literal: true

class ResourceRecommendations
  def initialize(moment)
    @moment = moment
    @moment_keywords = []
  end

  def call
    @moment_keywords = MomentKeywords.new(@moment).call
    all_resources.select do |resource|
      resource['tags'].any? do |tag|
        @moment_keywords.match?(tag)
      end
    end
  end

  def matched_tags
    @moment_keywords = MomentKeywords.new(@moment).call
    resource_tags = all_resources.flat_map do |resource|
      resource['tags'].select do |tag|
        @moment_keywords.match?(tag)
      end
    end
    resource_tags
  end

  private

  def all_resources
    resources = JSON.parse(File.read('doc/pages/resources.json'))
    resources.each do |item|
      item['tags'].map! { |tag| I18n.t("pages.resources.tags.#{tag}") }
    end
    resources
  end
end
