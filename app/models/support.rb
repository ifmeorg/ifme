# == Schema Information
#
# Table name: supports
#
#  id           :integer          not null, primary key
#  userid       :integer
#  support_type :string
#  support_ids  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Support < ActiveRecord::Base
  validates :userid, :support_type, :support_ids, presence: true
  serialize :support_ids, Array
  validates :support_type, inclusion: %w[category mood moment strategy]
  before_save :array_data

  def array_data
    return unless support_ids.is_a?(Array)
    self.support_ids = support_ids.collect(&:to_i)
  end
end
