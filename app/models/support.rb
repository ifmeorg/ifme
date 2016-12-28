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
  validates_presence_of :userid, :support_type, :support_ids
  serialize :support_ids, Array
  validates :support_type, inclusion: %w(category mood moment strategy)
  before_save :array_data

  def array_data
    if !support_ids.nil? && support_ids.is_a?(Array)
      self.support_ids = support_ids.collect(&:to_i)
    end
  end
end
