# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  comment_type :string
#  commented_on :integer
#  comment_by   :integer
#  comment      :text
#  created_at   :datetime
#  updated_at   :datetime
#  visibility   :string
#  viewers      :text
#

describe Comment do
	it "posts a valid comment" do
	  new_user = create(:user1)
	  new_category = create(:category, userid: new_user.id)
	  new_mood = create(:mood, userid: new_user.id)
	  new_strategies = create(:strategy, userid: new_user.id)
	  new_moment = create(:moment, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(1, new_mood.id), strategies: Array.new(1, new_strategies.id))
	  new_comment = create(:comment, commented_on: new_moment.id, comment_by: new_user.id, visibility: 'all')
	  expect(Comment.count).to eq(1)
	end

	it "posts an invalid comment" do
	  new_user = create(:user1)
	  new_category = create(:category, userid: new_user.id)
	  new_mood = create(:mood, userid: new_user.id)
	  new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
	  new_comment = build(:comment, commented_on: new_moment.id, visibility: 'all')

	  expect(new_comment).to have(1).error_on(:comment_by)
	end
end
