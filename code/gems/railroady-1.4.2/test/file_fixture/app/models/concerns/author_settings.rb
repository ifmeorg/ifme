module AuthorSettings   
  extend ActiveSupport::Concern

  included do
    before_validation :set_up_author
  end

  def set_up_author
    self.created_by = 'Admin'
    self.updated_by = 'Admin'
  end
end