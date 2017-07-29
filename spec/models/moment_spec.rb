# == Schema Information
#
# Table name: moments
#
#  id         :integer          not null, primary key
#  category   :text
#  name       :string
#  mood       :text
#  why        :text
#  fix        :text
#  created_at :datetime
#  updated_at :datetime
#  userid     :integer
#  viewers    :text
#  comment    :boolean
#  strategies :text
#  slug       :string
#

describe Moment do
	describe "POST create" do
		it "create private moment" do
			new_user = create(:user1)
			new_category = create(:category, userid: new_user.id)
			new_mood = create(:mood, userid: new_user.id)
			new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
			expect(new_moment.viewers).to be_empty
		  end
	end
	describe "POST create" do
		it "create public moment" do
			new_user = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user.id, ally_id: new_user2.id)
				new_category = create(:category, userid: new_user.id)
			new_mood = create(:mood, userid: new_user.id)
			new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), viewers: [new_user2.id])
			expect(new_moment.viewers.count).to eq(1)
		end
	end
end
