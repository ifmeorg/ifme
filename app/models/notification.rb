# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  userid     :integer
#  uniqueid   :string(255)
#  data       :text
#

class Notification < ActiveRecord::Base
  validates_presence_of :userid, :uniqueid, :data
  belongs_to :user, foreign_key: :userid
end
