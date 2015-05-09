class Viewer < ActiveRecord::Base
	attr_accessible :userid, :triggerid, :viewerid
	validates_uniqueness_of :userid, :scope => [:triggerid, :viewerid]
end
