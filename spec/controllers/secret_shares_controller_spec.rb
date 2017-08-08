describe SecretSharesController do
  describe "POST create" do
    it "Creates Secret Share Identifier" do
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      new_strategies = create(:strategy, userid: new_user.id)
      new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), strategies: Array.new(1, new_strategies.id))
      post :create, moment: new_moment.id
      expect(new_moment.reload.secret_share_identifier).not_to be_nil
    end
  end
end
