# == Schema Information
#
# Table name: alerts
#
#  id          :integer          not null, primary key
#  userid      :integer
#  trigger     :integer
#  medication  :integer
#  message     :string(255)
#  means       :string(255)
#  days        :string(255)
#  time_hour   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#  time_minute :string(255)
#  time_period :string(255)
#

class Alert < ActiveRecord::Base
	attr_accessor :user_id, :trigger, :medication, :message, :means, :days, :name, :time_hour, :time_minute, :time_period

    validates :means, inclusion: %w(sms email calendar)
    validates_presence_of :user_id, :days, :name, :time_hour, :time_minute, :time_period
end
