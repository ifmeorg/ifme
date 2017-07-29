# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  userid     :integer
#  uniqueid   :string
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ActiveRecord::Base
  validates :userid, :uniqueid, :data, presence: true
  belongs_to :user, foreign_key: :userid
end
