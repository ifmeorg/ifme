# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id     :integer
#  uniqueid   :string(255)
#  data       :text
#

class Notification < ActiveRecord::Base
  validates_presence_of :user_id, :uniqueid, :data
end
