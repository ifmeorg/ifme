# frozen_string_literal: true

class MomentKeywords
  def initialize(moment)
    @moment = moment
    @moment_keywords = []
  end

  def extract_moment_keywords
    extract_keywords(@moment.categories)
    extract_keywords(@moment.moods)
    extract_keywords(@moment.strategies)
    @moment_keywords.push(extract(@moment.name), extract(@moment.why), extract(@moment.fix))
    remove_special_chars
    downcase_keywords
  end

  private

  def strip_html(str)
    ActionController::Base.helpers.strip_tags(str)
  end

  def extract_keywords(array)
    array.each do |item|
      @moment_keywords.push(item['name'].split,
                            strip_html(item['description']).split)
    end
  end

  def extract(array)
    strip_html(array).split
  end

  def remove_special_chars
    @moment_keywords = @moment_keywords.flatten.each do |keyword|
      keyword.gsub!(/[\-_]/, ' ')
      keyword.gsub!(/[^\p{Alpha} -]/, '')
    end
  end

  def downcase_keywords
    @moment_keywords = @moment_keywords.map(&:downcase)
  end
end
