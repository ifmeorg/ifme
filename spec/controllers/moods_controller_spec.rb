RSpec.describe MoodsController, type: :controller do
  let(:user) { create(:user1) }

  describe "GET #index" do
    context "when the user is logged in" do
      include_context :logged_in_user
      it "renders the page" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "when the user is not logged in" do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe "GET #show" do

  end

  describe "GET #new" do
    context "when the user is logged in" do
      include_context :logged_in_user
      it "renders the page" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "when the user is not logged in" do
      before { get :new }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe "GET #edit" do
    let(:user_mood) { create(:mood, userid: user.id) }
    let(:other_mood) { create(:mood, userid: user.id+1) }

    context "when the user is logged in" do
      include_context :logged_in_user
      context "user is trying to edit a mood they created" do
        it "renders the edit form" do
          get :edit, id: user_mood.id
          expect(response).to render_template(:edit)
        end
      end
      context "user is trying to edit a mood another user created" do
        it "redirects to the mood path" do
          get :edit, id: other_mood.id
          expect(response).to redirect_to mood_path(other_mood)
        end
      end
    end

    context "when the user is not logged in" do
      before { get :edit, id: user_mood.id }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe "POST #create" do
    let(:valid_mood_params) { FactoryGirl.attributes_for(:mood).merge(userid: user.id) }
    let(:invalid_mood_params) { FactoryGirl.attributes_for(:mood) }

    context "when the user is logged in" do
      include_context :logged_in_user
      context "when valid params are supplied" do
        it "creates a mood" do
          expect{ post :create, mood: valid_mood_params }.to change(Mood, :count).by(1)
        end
        it "redirects to the mood page" do
          post :create, mood: valid_mood_params
          expect(response).to redirect_to mood_path(assigns(:mood))
        end
      end
      context "when invalid params are supplied" do
        before { post :create, mood: invalid_mood_params }
        it "re-renders the creation form" do
          expect(response).to render_template(:new)
        end
        it "adds errors to the mood ivar" do
          expect(assigns(:mood).errors).not_to be_empty
        end
      end
    end

    context "when the user is not logged in" do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
