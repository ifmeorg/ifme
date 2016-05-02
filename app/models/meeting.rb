# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  location    :text
#  time        :string(255)
#  maxmembers  :integer
#  groupid     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  date        :string(255)
#

class Meeting < ActiveRecord::Base
	attr_accessible :name, :description, :location, :time, :maxmembers, :groupid, :date

	validates_presence_of :name, :description, :location, :time, :groupid, :date
end
