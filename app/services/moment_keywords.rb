# frozen_string_literal: true

class MomentKeywords
  def initialize(moment)
    @moment = moment
    @moment_keywords = []
  end

  def call
    collect_keywords(@moment.categories)
    collect_keywords(@moment.moods)
    collect_keywords(@moment.strategies)
    @moment_keywords.push(extract(@moment.name),
                          extract(@moment.why),
                          extract(@moment.fix))
    @moment_keywords = @moment_keywords.join(' ')
  end

  private

  def strip_html(str)
    ActionController::Base.helpers.strip_tags(str)
  end

  def collect_keywords(array)
    array.each do |item|
      @moment_keywords.push(extract(item['name']),
                            extract(item['description']))
    end
  end

  def extract(str)
    str ||= ''
    str = strip_html(str.tr('\\', '/'))
    str.gsub(/[^\p{Alpha} -]/, '').split.map(&:downcase)
  end
end
