require 'spec_helper'

describe Comment do
	it "posts a valid comment" do
	  new_user = create(:user)
	  new_category = create(:category, userid: new_user.id)
	  new_mood = create(:mood, userid: new_user.id)
	  new_trigger = create(:trigger, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
	  new_comment = create(:comment, commented_on: new_trigger.id, comment_by: new_user.id)
	  expect(Comment.count).to eq(1)
	end

	it "posts an invalid comment" do
	  new_user = create(:user)
	  new_category = create(:category, userid: new_user.id)
	  new_mood = create(:mood, userid: new_user.id)
	  new_trigger = create(:trigger, userid: new_user.id, category: Array.new(new_category.id), mood: Array.new(new_mood.id))
	  new_comment = build(:comment, commented_on: new_trigger.id)

	  new_comment.should have(1).error_on(:comment_by)
	end
end
