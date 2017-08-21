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
    let(:user_mood) { create(:mood, userid: user.id) }
    let(:other_mood) { create(:mood, userid: ally.id) }

    context "when the user is logged in" do
      include_context :logged_in_user
      it "renders the page" do
        get :show, id: user_mood.id
        expect(response).to render_template(:show)
      end
      context "when the user created the mood" do
        before { get :show, id: user_mood.id }
        it "passes the edit link and tooltip text to the template" do
          expect(assigns(:page_edit)).to eq edit_mood_path(user_mood)
          expect(assigns(:page_tooltip)).to eq I18n.t('moods.edit_mood')
        end
      end
      context "when the user is an ally and viewer" do
        xit "passes a link to the author to the template" do
        end
      end
      context "by default" do
        before { get :show, id: other_mood.id }
        it "redirects to the mood index page" do
          expect(response).to redirect_to moods_path
        end
      end
    end
    context "when the user is not logged in" do
      before { get :show, id: user_mood.id }
      it_behaves_like :with_no_logged_in_user
    end
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
          expect{ post :create, mood: valid_mood_params }.to change(Mood, :count).by 1
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

  describe "POST #premade" do
    context "when the user is logged in" do
      include_context :logged_in_user
      it "creates 5 premade moods" do
        expect{ post :premade }.to change(Mood, :count).by 5
      end
      it "redirects to the mood index page" do
        post :premade
        expect(response).to redirect_to moods_path
      end
    end
    context "when the user is not logged in" do
      before { post :premade }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe "PATCH/PUT #update" do
    let(:user_mood) { create(:mood, userid: user.id) }
    let(:valid_mood_params) { { name: "updated name" } }
    let(:invalid_mood_params) { { name: nil } }

    context "when the user is logged in" do
      include_context :logged_in_user
      context "when valid params are supplied" do
        before { patch :update, id: user_mood.id, mood: valid_mood_params }
        it "updates the mood" do
          expect(user_mood.reload.name).to eq "updated name"
        end
        it "redirects to the mood page" do
          expect(response).to redirect_to mood_path(assigns(:mood))
        end
      end
      context "when invalid params are supplied" do
        before { patch :update, id: user_mood.id, mood: invalid_mood_params }
        it "re-renders the edit form" do
          expect(response).to render_template(:edit)
        end
        it "adds errors to the mood ivar" do
          expect(assigns(:mood).errors).not_to be_empty
        end
      end
    end
    context "when the user is not logged in" do
      before { patch :update, id: user_mood.id }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe "DELETE #destroy" do
    let(:user_mood) { create(:mood, userid: user.id) }
    let!(:moment) { create(:moment, userid: user.id, mood: [user_mood.id]) }

    context "when the user is logged in" do
      include_context :logged_in_user
      it "deletes the mood" do
        expect{ delete :destroy, id: user_mood.id }.to change(Mood, :count).by(-1)
      end
      it "removes moods from existing moments" do
        delete :destroy, id: user_mood.id
        expect(moment.reload.mood).not_to include(user_mood.id)
      end
      it "redirects to the mood index page" do
        delete :destroy, id: user_mood.id
        expect(response).to redirect_to moods_path
      end
    end
    context "when the user is not logged in" do
      before { delete :destroy, id: user_mood.id }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe "#quick_create" do
    # TODO
  end
end
