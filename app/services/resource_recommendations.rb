# frozen_string_literal: true

class ResourceRecommendations
  def initialize(moment)
    @moment = moment
    @moment_keywords = []
  end

  def call
    @moment_keywords = MomentKeywords.new(@moment).call
    all_resources.select do |resource|
      tags = resource['tags'].flat_map do |tag|
        tag.tr('_', ' ')
      end
      (tags & @moment_keywords).any?
    end
  end

  def matched_tags
    @moment_keywords = MomentKeywords.new(@moment).call
     resource_tags = all_resources.flat_map do |resource|
       resource['tags']
     end
     matched_tags = (@moment_keywords & resource_tags)
  end

  private

  def all_resources
    JSON.parse(File.read(Rails.root.join('doc', 'pages', 'resources.json')))
  end
end
