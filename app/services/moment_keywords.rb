class MomentKeywords
  def initialize(moment)
    @moment = moment
    @moment_keywords = []
  end
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

  def downcase_keywords
    @moment_keywords = @moment_keywords.map(&:downcase)
  end
end
