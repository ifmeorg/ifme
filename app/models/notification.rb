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
	attr_accessible :userid, :uniqueid, :data
	validates_presence_of :userid, :uniqueid, :data
end
