class Alert < ActiveRecord::Base
	attr_accessible :userid, :trigger, :medication, :message, :means, :days, :times, :name

    validates :means, inclusion: %w(sms email calendar)
end
