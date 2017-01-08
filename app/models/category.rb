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
  friendly_id :name, use: :slugged
  validates_length_of :description, :maximum => 2000
  validates_presence_of :userid, :name

  def self.link
    '/categories/'
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
