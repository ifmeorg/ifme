require 'spec_helper'

describe Ally do
	it "creates a valid ally relationship with accepted status" do
	  new_user1 = create(:user1)
	  new_user2 = create(:user2)
	  new_allies = create(:allies_accepted, userid1: new_user1.id, userid2: new_user2.id)
	  expect(Ally.count).to eq(1)
	end

	it "creates a valid ally relationship with pending_from_userid1 status" do
	  new_user1 = create(:user1)
	  new_user2 = create(:user2)
	  new_allies = create(:allies_pending_from_userid1, userid1: new_user1.id, userid2: new_user2.id)
	  expect(Ally.count).to eq(1)
	end

	it "creates a valid ally relationship with pending_from_userid2 status" do
	  new_user1 = create(:user1)
	  new_user2 = create(:user2)
	  new_allies = create(:allies_pending_from_userid2, userid1: new_user1.id, userid2: new_user2.id)
	  expect(Ally.count).to eq(1)
	end

	it "creates an invalid ally relationship where users are identical" do
	  new_user1 = create(:user1)
	  new_allies = build(:allies_accepted, userid1: new_user1.id, userid2: new_user1.id)
	  expect(new_allies).to have(1).error_on(:userid1)
	end

	it "creates an invalid ally relationship where user1 is nil" do
	  new_user2 = create(:user2)
	  new_allies = build(:allies_accepted, userid1: nil, userid2: new_user2.id)
	  expect(new_allies).to have(1).error_on(:userid1)
	end

	it "creates an invalid ally relationship where user2 is nil" do
	  new_user1 = create(:user1)
	  new_allies = build(:allies_accepted, userid1: new_user1.id, userid2: nil)
	  expect(new_allies).to have(1).error_on(:userid2)
	end
end
