class Mood < ActiveRecord::Base
	attr_accessible :name, :description, :userid
end
