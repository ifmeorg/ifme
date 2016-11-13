# == Schema Information
#
# Table name: supports
#
#  id           :integer          not null, primary key
#  userid       :integer
#  support_type :string
#  support_ids  :text
#  created_at   :datetime
#  updated_at   :datetime
#

describe Support do
 	it "gives valid support to one moment" do
	  new_user = create(:user1)
	  new_category = create(:category, userid: new_user.id)
	  new_mood = create(:mood, userid: new_user.id)
	  new_strategies = create(:strategy, userid: new_user.id)
	  new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), strategies: Array.new(1, new_strategies.id))
	  new_support = Support.create(:userid => new_user.id, :support_type => "moment", :support_ids => Array.new(1, new_moment.id))
	  expect(Support.count).to eq(1)
	end

	it "gives valid support to multiple moments" do
	  new_user = create(:user1)
	  new_category = create(:category, userid: new_user.id)
	  new_mood = create(:mood, userid: new_user.id)
	  new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
	  other_new_moment = Moment.create(userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), name: "Test Moment 2", why: "Test Why 2", fix: "Test fix 2")
	  new_support = Support.create(:userid => new_user.id, :support_type => "moment", :support_ids => Array.new([new_moment.id, other_new_moment.id]))
	  expect(Support.count).to eq(1)
	end
end
