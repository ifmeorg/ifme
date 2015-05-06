class SessionMember < ActiveRecord::Base
	attr_accessible :sessionid, :userid, :leader

	validates_presence_of :sessionid, :userid
	validates :leader, inclusion: [true, false]
end
