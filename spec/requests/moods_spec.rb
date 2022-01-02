# frozen_string_literal: true

describe 'Moods', type: :request do
  let(:user)                { create(:user1) }
  let(:user_mood)           { create(:mood, user_id: user.id) }
  let(:other_mood)          { create(:mood, user_id: user.id + 1) }
  let(:valid_mood_params)   { attributes_for(:mood) }
  let(:invalid_mood_params) { { name: nil, description: nil } }
  let(:json_header)         { { "ACCEPT" => "application/json" } }

  describe '#index' do
    context 'when the request type is HTML' do
      it 'lists all the user moods' do
        user_mood
        sign_in user
        get moods_path
        expect(response.body).to include 'Test Mood'
        expect(assigns(:moods)).to eq [user_mood]
        expect(assigns(:page_new)).to eq I18n.t('moods.new')
      end
    end

    context 'when the request type is JSON' do
      it 'lists all the user moods' do
        user_mood
        sign_in user
        get moods_path, headers: json_header
        result = JSON.parse(response.body)
        expect(result['data'].first['link']).to eq mood_path(user_mood)
      end
    end

    context 'when the user is not logged in' do
      before { get moods_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#show' do
    context 'when the user is logged in' do
      context 'when the user created the mood' do
        it 'renders the page' do
          sign_in user
          get mood_path(user_mood)
          expect(response).to render_template(:show)
          expect(response.body).to include 'Test Mood'
          expect(assigns(:mood)).to eq user_mood
        end
      end

      context "when the user didn't create the mood" do
        it 'redirects to the mood index page' do
          sign_in user
          get mood_path(other_mood)
          expect(response).to redirect_to moods_path
        end
      end
    end

    context 'when the user is not logged in' do
      before { get mood_path(user_mood) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#new' do
    context 'when the user is logged in' do
      it 'renders the page' do
        sign_in user
        get new_mood_path
        expect(response).to render_template(:new)
        expect(response.body).to include 'New Mood'
      end
    end

    context 'when the user is not logged in' do
      before { get new_mood_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#edit' do
    context 'when the user is logged in' do
      context 'user is trying to edit a mood they created' do
        it 'renders the edit form' do
          sign_in user
          get edit_mood_path(user_mood)
          expect(response).to render_template(:edit)
          expect(response.body).to include 'Edit Test Mood'
        end
      end

      context 'user is trying to edit a mood another user created' do
        it 'redirects to the mood path' do
          sign_in user
          get edit_mood_path(other_mood)
          expect(response).to redirect_to mood_path(other_mood)
        end
      end
    end

    context 'when the user is not logged in' do
      before { get edit_mood_path(user_mood) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#create' do
    context 'when the user is logged in' do
      context 'when valid params are supplied' do
        it 'creates a mood' do
          expect(Mood.all.count).to eq 0
          sign_in user
          post moods_path, params: { mood: valid_mood_params }
          expect(Mood.all.count).to eq 1
          expect(response).to redirect_to mood_path(assigns(:mood))
        end
      end

      context 'when invalid params are supplied' do
        it 're-renders the creation form' do
          expect(Mood.all.count).to eq 0
          sign_in user
          post moods_path, params: { mood: invalid_mood_params }
          expect(response).to render_template(:new)
          expect(assigns(:mood).errors).not_to be_empty
          expect(Mood.all.count).to eq 0
        end
      end

      context 'when the user_id is hacked' do
        it 'creates a new mood, ignoring the user_id parameter' do
          # passing a user_id isn't an error, but it shouldn't
          # affect the owner of the created item
          another_user = create(:user2)
          hacked_mood_params =
            valid_mood_params.merge(user_id: another_user.id)
          sign_in user
          post moods_path, params: { mood: hacked_mood_params }
          expect(Mood.all.count).to eq 1
          expect(Mood.last.user_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post moods_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#premade' do
    context 'when the user is logged in' do
      it 'redirects to the mood index page' do
        expect(Mood.all.count).to eq 0
        sign_in user
        post premade_moods_path
        expect(response).to redirect_to moods_path
        expect(Mood.all.count).to eq 5
      end
    end

    context 'when the user is not logged in' do
      before { post premade_moods_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#update' do
    let(:valid_update_params) { { name: 'updated name' } }
    let(:invalid_update_params) { { name: nil } }

    context 'when the user is logged in' do
      context 'when valid params are supplied' do
        it 'updates the mood' do
          sign_in user
          patch mood_path(user_mood), params: { id: user_mood.id, mood: valid_update_params }
          expect(user_mood.reload.name).to eq 'updated name'
          expect(response).to redirect_to mood_path(assigns(:mood))
        end
      end

      context 'when invalid params are supplied' do
        it 're-renders the edit form' do
          sign_in user
          patch mood_path(user_mood), params: { id: user_mood.id, mood: invalid_update_params }
          expect(response).to render_template(:edit)
          expect(assigns(:mood).errors).not_to be_empty
        end
      end
    end

    context 'when the user is not logged in' do
      before { patch mood_path(user_mood) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let!(:moment) { create(:moment, user_id: user.id, mood: [user_mood.id]) }

    context 'when the user is logged in' do
      it 'deletes the mood' do
        expect(Mood.all.count).to eq 1
        sign_in user
        delete mood_path(user_mood)
        expect(Mood.all.count).to eq 0
        # Remove moods from existing moment
        expect(moment.reload.moods).not_to include(user_mood)
        expect(response).to redirect_to moods_path
      end
    end

    context 'when the user is not logged in' do
      before { delete mood_path(user_mood) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#quick_create' do
    context 'when the user is logged in' do
      context 'when valid params are supplied' do
        it 'responds with a checkbox in json format' do
          expect(Mood.all.count).to eq 0
          sign_in user
          post quick_create_moods_path, params: { mood: valid_mood_params }
          expect(Mood.all.count).to eq 1
          expect(response.body).to eq({
            success: true,
            id: Mood.last.id,
            name: Mood.last.name,
            slug: Mood.last.slug
          }.to_json)
        end
      end

      context 'when invalid params are supplied' do
        it 'responds with an error in json format' do
          sign_in user
          post quick_create_moods_path, params: { mood: invalid_mood_params }
          expect(response.body).to eq({ success: false }.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post quick_create_moods_path }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
