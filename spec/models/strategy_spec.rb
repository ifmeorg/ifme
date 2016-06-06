# == Schema Information
#
# Table name: strategies
#
#  id          :integer          not null, primary key
#  user_id      :integer
#  category    :text
#  description :text
#  viewers     :text
#  comment     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#

require 'rails_helper'

describe Strategy do
 	it "creates a strategy" do
 		new_user1 = create(:user1)
 		new_category = create(:category, user_id: new_user1.id)
 		new_user2 = create(:user2)
 		new_strategy = create(:strategy, user_id: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
	  	expect(Strategy.count).to eq(1)
 	end

 	it "does not create a strategy" do
 		new_user1 = create(:user1)
 		new_category = create(:category, user_id: new_user1.id)
 		new_user2 = create(:user2)
 		new_strategy = build(:strategy, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
	  	expect(new_strategy).to have(1).error_on(:user_id)
 	end
end
