describe MomentsController do
  describe "signed in" do
    it "GET index" do
      new_user = create(:user1)
      sign_in new_user
      get :index
      expect(response).to render_template(:index)
    end

    it "POST new" do
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      new_moment = attributes_for(:moment).merge(userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
      get :new
      expect(response).to render_template(:new)
      expect{post :create,  moment: new_moment}.to change(Moment, :count).by(1)
    end

    it "GET show" do
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      new_strategies = create(:strategy, userid: new_user.id)
      new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), strategies: Array.new(1, new_strategies.id))
      get :show, id: new_moment
      expect(response).to render_template(:show)
    end
  end
end
