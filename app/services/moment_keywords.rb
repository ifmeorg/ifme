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
