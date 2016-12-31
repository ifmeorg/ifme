# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  userid      :integer
#

class Mood < ActiveRecord::Base
  validates :description, length: { maximum: 2000 }
  validates :userid, :name, presence: true

  def self.link
    'moods'
  end
end
