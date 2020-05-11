# frozen_string_literal: true

describe MomentsController do
  let(:user) { create(:user) }
  let(:moment) { build(:moment, user: user) }

  describe '#index' do
    before { sign_in user }

    it 'renders template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when request type is JSON' do
      let(:moment) { create(:moment, user: user) }
      before { get :index, params: { page: 1, id: moment.id }, format: :json }
      it 'returns a response with the correct path' do
        expect(JSON.parse(response.body)['data'].first['link']).to eq moment_path(moment)
      end
    end
  end

  describe '#new' do
    before { sign_in user }

    it 'creates a new moment' do
      get :new
      expect(response).to render_template(:new)
      expect { post :create, params: { moment: moment.attributes } }
        .to(change(Moment, :count).by(1))
    end
  end

  describe '#edit' do
    let(:another_user) { create(:user) }
    let!(:moment1)   { create(:moment, user: user) }
    let!(:moment2)   { create(:moment, user: another_user) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the moment belongs to the current user' do
        it 'renders the edit template' do
          get :edit, params: { id: moment1.id }
          expect(response).to render_template('edit')
        end
      end

      context 'when the moment does not belong to the current user' do
        it 'redirects html requests to the strategy_path' do
          get :edit, params: { id: moment2.id }
          expect(response).to redirect_to(moment_path(moment2))
        end

        it 'renders nothing for json requests' do
          get :edit, format: 'json', params: { id: moment2.id }
          expect(response.body).to be_empty
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :edit, params: { id: moment2.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#show' do
    before { sign_in user }

    it 'renders template' do
      moment.save!
      get :show, params: { id: moment.id }
      expect(response).to render_template(:show)
    end
  end

  describe '#create' do
    let(:valid_moment_params) { attributes_for(:moment) }

    before { sign_in user }

    def post_create(moment_params)
      post :create, params: { moment: moment_params }
    end

    context 'when valid params are supplied' do
      it 'creates a moment' do
        expect { post_create valid_moment_params }
          .to change(Moment, :count).by(1)
      end

      it 'has no validation errors' do
        post_create valid_moment_params
        expect(assigns(:moment).errors).to be_empty
      end

      it 'redirects to the moment page' do
        post_create valid_moment_params
        expect(response).to redirect_to moment_path(assigns(:moment))
      end
    end

    context 'when invalid params are supplied' do
      let(:invalid_moment_params) { valid_moment_params.merge(name: nil, why: nil) }

      before { post_create invalid_moment_params }

      it 're-renders the creation form' do
        expect(response).to render_template(:new)
      end

      it 'adds errors to the moment ivar' do
        expect(assigns(:moment).errors).not_to be_empty
      end
    end

    context 'when the user_id is hacked' do
      it 'creates a new moment, ignoring the user_id parameter' do
        # passing a user_id isn't an error, but it shouldn't
        # affect the owner of the created item
        another_user = create(:user2)
        hacked_moment_params =
          valid_moment_params.merge(user_id: another_user.id)
        expect { post_create hacked_moment_params }
          .to change(Moment, :count).by(1)
        expect(Moment.last.user_id).to eq(user.id)
      end
    end
  end

  describe '#update' do
    let!(:moment) { create(:moment, user: user, resource_recommendations: true) }
    let(:valid_moment_params)   { { why: 'updated why', resource_recommendations: false } }
    let(:invalid_moment_params) { { why: nil } }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the params are valid' do
        before(:each) do
          patch :update, params: { id: moment.id, moment: valid_moment_params }
        end

        it 'updates the moment record' do
          expect(moment.reload.why).to eq('updated why')
        end

        it 'updates the resource_recommendations toggle' do
          expect(moment.reload.resource_recommendations).to eq(false)
        end

        it 'redirects to the show page' do
          expect(response).to redirect_to(moment_path(moment))
        end
      end

      context 'when the params are invalid' do
        before(:each) do
          patch :update, params: { id: moment.id, moment: invalid_moment_params }
        end

        it 'does not update the record' do
          expect(moment.reload.why).to eq('Test Why')
        end

        it 'renders the edit view' do
          expect(response).to render_template('edit')
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        patch :update, params: { id: moment.id }
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let!(:moment) { create(:moment, user: user) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      it 'destroys the moment' do
        expect { delete :destroy, params: { id: moment.id } }.to(
          change(Moment, :count).by(-1)
        )
      end

      it 'redirects to the moments path for html requests' do
        delete :destroy, params: { id: moment.id }
        expect(response).to redirect_to(moments_path)
      end

      it 'responds with no content to json requests' do
        delete :destroy, format: 'json', params: { id: moment.id }
        expect(response.body).to be_empty
      end
    end

    context 'when the user is not logged in' do
      before { delete :destroy, params: { id: moment.id } }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#tagged' do
    let!(:category) { create(:category, user_id: user.id) }
    let!(:mood) { create(:mood, user_id: user.id) }
    let!(:strategy) { create(:strategy, user_id: user.id) }
    let!(:moment) { create(:moment, user_id: user.id, category: [category.id], mood: [mood.id], strategy: [strategy.id]) }

    context 'when the user is logged in' do
      include_context :logged_in_user
      before do
        get :tagged, params: { page: 1, category_id: category.id, mood_id: mood.id, strategy_id: strategy.id }, format: :json
      end

      it 'returns a response with the correct path' do
        expect(JSON.parse(response.body)['data'].first['link']).to eq moment_path(moment)
      end
    end

    context 'when the user is not logged in' do
      before do
        get :tagged, params: { page: 1, category_id: category.id, mood_id: mood.id, strategy_id: strategy.id }, format: :json
      end

      it 'returns a no_content status' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'Moment Analytic Charts' do
    it 'should contain react analytics objects' do
      create_time = Date.current
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, user_id: new_user.id)
      new_mood = create(:mood, user_id: new_user.id)
      create(:moment, user_id: new_user.id, category: Array.new(1, new_category.id),
                      mood: Array.new(1, new_mood.id), created_at: create_time)
      get :index
      expect(assigns(:react_moments)).to have_key(create_time)
      expect(assigns(:react_moments)[create_time]).to eq(1)
    end
  end
end
