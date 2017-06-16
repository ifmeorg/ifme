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
#  slug        :string
#

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  validates_length_of :description, :maximum => 2000
  validates_presence_of :userid, :name

  def self.link
    '/categories/'
  end
end
