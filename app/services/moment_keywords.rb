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
    remove_special_chars
    downcase_keywords
    @moment_keywords = @moment_keywords.join(' ')
  end

  private

  def strip_html(str)
    ActionController::Base.helpers.strip_tags(str)
  end

  def collect_keywords(array)
    array.each do |item|
      @moment_keywords.push(item['name'].split,
                            extract(item['description']))
    end
  end

  def extract(array)
    strip_html(array).split
  end

  def remove_special_chars
    @moment_keywords = @moment_keywords.flatten.each do |keyword|
      keyword.gsub!(/[^\p{Alpha} -]/, '')
    end
  end

  def downcase_keywords
    @moment_keywords = @moment_keywords.map(&:downcase)
  end
end
