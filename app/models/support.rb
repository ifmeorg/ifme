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
  include SerializableData

  validates :userid, :support_type, :support_ids, presence: true
  validates :support_type, inclusion: %w(category mood moment strategy)

  serialize :support_ids, Array

  array_data_variables :support_ids
end
