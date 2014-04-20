class Alert < ActiveRecord::Base
	attr_accessible :userid, :trigger, :medication, :message, :means, :days, :name, :time_hour, :time_minute, :time_period

    validates :means, inclusion: %w(sms email calendar)
end
