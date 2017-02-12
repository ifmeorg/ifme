# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  userid      :integer
#

class Category < ActiveRecord::Base
  extend FriendlyId

  validates :description, length: { maximum: 2000 }
  validates :userid, :name, presence: true

  friendly_id :name

  def self.link
    '/categories/'
  end
end
