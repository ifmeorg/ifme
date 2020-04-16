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
    extract_moment_name
    extract_moment_why
    extract_moment_fix
    remove_special_chars
    downcase_keywords
  end

  private

  def strip_tags(str)
    ActionController::Base.helpers.strip_tags(str)
  end

  def extract_keywords(array)
    array.each do |item|
      @moment_keywords.push(item['name'].split,
                            strip_tags(item['description']).split)
    end
  end

  def extract_moment_name
    @moment_keywords.push(@moment.name.split)
  end

  def extract_moment_why
    @moment_keywords.push(strip_tags(@moment.why).split)
  end

  def extract_moment_fix
    @moment_keywords.push(strip_tags(@moment.fix).split)
  end

  def remove_special_chars
    @moment_keywords = @moment_keywords.flatten.each do |keyword|
      keyword.tr!('-', ' ')
      keyword.gsub!(/[^\p{Alpha} -]/, '')
    end
  end

  def downcase_keywords
    @moment_keywords = @moment_keywords.map(&:downcase)
  end
end
