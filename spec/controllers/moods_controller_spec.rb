# frozen_string_literal: true

RSpec.describe MoodsController, type: :controller do
  let(:user) { create(:user1) }
  let(:another_user) { create(:user2) }
  let(:user_mood) { create(:mood, userid: user.id) }
  let(:other_mood) { create(:mood, userid: user.id + 1) }
  let(:valid_mood_params) { attributes_for(:mood) }
  let(:invalid_mood_params) { { name: nil, description: nil } }
  let(:hacked_mood_params) { valid_mood_params.merge(userid: another_user.id) }

  describe 'GET #index' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      before { get :index }
      it 'sets the categories and page tooltip ivar' do
        expect(assigns(:moods)).to eq [user_mood]
        expect(assigns(:page_tooltip)).to eq I18n.t('moods.new')
      end
      it 'renders the page' do
        expect(response).to render_template(:index)
      end
    end
    context 'when the user is not logged in' do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #show' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when the user created the mood' do
        before { get :show, params: { id: user_mood.id } }
        it 'passes the edit link and tooltip text to the template' do
          expect(assigns(:page_edit)).to eq edit_mood_path(user_mood)
          expect(assigns(:page_tooltip)).to eq I18n.t('moods.edit_mood')
        end
        it 'renders the page' do
          expect(response).to render_template(:show)
        end
      end
      context "when the user didn't create the mood" do
        before { get :show, params: { id: other_mood.id } }
        it 'redirects to the mood index page' do
          expect(response).to redirect_to moods_path
        end
      end
    end
    context 'when the user is not logged in' do
      before { get :show, params: { id: user_mood.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #new' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'renders the page' do
        get :new
        expect(response).to render_template(:new)
      end
    end
    context 'when the user is not logged in' do
      before { get :new }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #edit' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'user is trying to edit a mood they created' do
        it 'renders the edit form' do
          get :edit, params: { id: user_mood.id }
          expect(response).to render_template(:edit)
        end
      end
      context 'user is trying to edit a mood another user created' do
        it 'redirects to the mood path' do
          get :edit, params: { id: other_mood.id }
          expect(response).to redirect_to mood_path(other_mood)
        end
      end
    end
    context 'when the user is not logged in' do
      before { get :edit, params: { id: user_mood.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #create' do
    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when valid params are supplied' do
        it 'creates a mood' do
          expect { post :create, params: { mood: valid_mood_params } }
            .to change(Mood, :count).by 1
        end
        it 'redirects to the mood page' do
          post :create, params: { mood: valid_mood_params }
          expect(response).to redirect_to mood_path(assigns(:mood))
        end
      end

      context 'when invalid params are supplied' do
        before { post :create, params: { mood: invalid_mood_params } }
        it 're-renders the creation form' do
          expect(response).to render_template(:new)
        end
        it 'adds errors to the mood ivar' do
          expect(assigns(:mood).errors).not_to be_empty
        end
      end

      context 'when the userid is hacked' do
        let(:mood_params) { { mood: hacked_mood_params } }

        it 'creates a new mood' do
          expect do
            post :create, params: mood_params
          end.to change(Mood, :count).by(1)
        end

        it 'uses the logged-in userid, not the one in the params' do
          post :create, params: mood_params
          expect(Mood.last.userid).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #premade' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'creates 5 premade moods' do
        expect { post :premade }.to change(Mood, :count).by 5
      end
      it 'redirects to the mood index page' do
        post :premade
        expect(response).to redirect_to moods_path
      end
    end
    context 'when the user is not logged in' do
      before { post :premade }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'PATCH/PUT #update' do
    let(:valid_update_params) { { name: 'updated name' } }
    let(:invalid_update_params) { { name: nil } }

    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when valid params are supplied' do
        before { patch :update, params: { id: user_mood.id, mood: valid_update_params } }
        it 'updates the mood' do
          expect(user_mood.reload.name).to eq 'updated name'
        end
        it 'redirects to the mood page' do
          expect(response).to redirect_to mood_path(assigns(:mood))
        end
      end
      context 'when invalid params are supplied' do
        before { patch :update, params: { id: user_mood.id, mood: invalid_update_params } }
        it 're-renders the edit form' do
          expect(response).to render_template(:edit)
        end
        it 'adds errors to the mood ivar' do
          expect(assigns(:mood).errors).not_to be_empty
        end
      end
    end
    context 'when the user is not logged in' do
      before { patch :update, params: { id: user_mood.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'DELETE #destroy' do
    let!(:moment) { create(:moment, userid: user.id, mood: [user_mood.id]) }

    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'deletes the mood' do
        expect { delete :destroy, params: { id: user_mood.id } }
          .to change(Mood, :count).by(-1)
      end
      it 'removes moods from existing moments' do
        delete :destroy, params: { id: user_mood.id }
        expect(moment.reload.mood).not_to include(user_mood.id)
      end
      it 'redirects to the mood index page' do
        delete :destroy, params: { id: user_mood.id }
        expect(response).to redirect_to moods_path
      end
    end
    context 'when the user is not logged in' do
      before { delete :destroy, params: { id: user_mood.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #quick_create' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when valid params are supplied' do
        it 'creates the mood' do
          expect { post :quick_create, params: { mood: valid_mood_params } }
            .to change(Mood, :count).by 1
        end
        it 'responds with a checkbox in json format' do
          post :quick_create, params: { mood: valid_mood_params }
          response_keys = JSON.parse(response.body).keys
          expect(response_keys).to contain_exactly('checkbox',
                                                   'label',
                                                   'wrapper_id',
                                                   'autocomplete_id',
                                                   'name',
                                                   'id')
        end
      end
      context 'when invalid params are supplied' do
        it 'responds with an error in json format' do
          post :quick_create, params: { mood: invalid_mood_params }
          expect(response.body).to eq({ error: 'error' }.to_json)
        end
      end
    end
    context 'when the user is not logged in' do
      before { post :quick_create }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
