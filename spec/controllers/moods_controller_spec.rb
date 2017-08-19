RSpec.describe MoodsController, type: :controller do
  let(:user) { create(:user1) }

  describe "GET #index" do
    context "when the user is logged in" do
      before do
        sign_in user
      end
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
      before do
        sign_in user
      end
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
      before do
        sign_in user
      end
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
      before { get :new }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
