class Ally < ActiveRecord::Base
	attr_accessible :userid, :allies
	serialize :allies, Array
end
