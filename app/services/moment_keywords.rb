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
