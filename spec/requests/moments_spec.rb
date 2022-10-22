# frozen_string_literal: true

describe 'Moments', type: :request do
  let(:user) { create(:user) }
  let(:moment) { build(:moment, user: user) }

  describe '#index' do
    before { sign_in user }

    it 'renders template' do
      get moments_path
      expect(response).to render_template(:index)
    end

    context 'when request type is JSON' do
      let(:moment) { create(:moment, user: user) }

      it 'returns a response with the correct path' do
        headers = { 'ACCEPT' => 'application/json'  }
        get moments_path, params: { page: 1, id: moment.id }, headers: headers
        expect(JSON.parse(response.body)['data'].first['link']).to eq moment_path(moment)
      end
    end
  end

  describe '#new' do
    before { sign_in user }

    it 'creates a new moment' do
      get new_moment_path
      expect(response).to render_template(:new)
      expect { post moments_path, params: { moment: moment.attributes } }
        .to(change(Moment, :count).by(1))
    end

    it 'does not show not_visible moods in dropdown' do
      mood1 = create(:mood, name: 'Invisible Mood', user: user, visible: false)
      mood2 = create(:mood, name: 'Visible Mood', user: user, visible: true)

      get new_moment_path
      expect(response.body).to include(mood2.name)
      expect(response.body).not_to include(mood1.name)
    end

    it 'does not show not_visible categories in dropdown' do
      category1 = create(:mood, name: 'Invisible Category', user: user, visible: false)
      category2 = create(:mood, name: 'Visible Category', user: user, visible: true)

      get new_moment_path
      expect(response.body).to include(category2.name)
      expect(response.body).not_to include(category1.name)
    end

    it 'does not show not_visible strategies in dropdown' do
      strategy1 = create(:strategy, name: 'Invisible Strategy', user: user, visible: false)
      strategy2 = create(:strategy, name: 'Visible Strategy', user: user, visible: true)

      get new_moment_path
      expect(response.body).to include(strategy2.name)
      expect(response.body).not_to include(strategy1.name)
    end
  end

  describe '#edit' do
    let(:another_user) { create(:user) }
    let!(:moment1)   { create(:moment, user: user) }
    let!(:moment2)   { create(:moment, user: another_user) }

    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the moment belongs to the current user' do
        it 'renders the edit template' do
          get edit_moment_path(moment1.id)
          expect(response).to render_template('edit')
        end

        it 'renders associated moods in dropdown regardless of visibility status' do
          mood1 = create(:mood, name: 'Invisible Mood', user: user, visible: false)
          mood2 = create(:mood, name: 'Visible Mood', user: user, visible: true)
          mood3 = create(:mood, name: 'Invisible but Associated Mood', user: user, visible: false)
          moment_mood = MomentsMood.create(moment_id: moment1.id, mood_id: mood3.id)

          get edit_moment_path(moment1.id)
          expect(response.body).to include(mood2.name)
          expect(response.body).not_to include(mood1.name)
          expect(response.body).to include(mood3.name)
        end
        
        it 'renders associated category in dropdown regardless of visibility status' do
          category1 = create(:category, name: 'Invisible Category', user: user, visible: false)
          category2 = create(:category, name: 'Visible Category', user: user, visible: true)
          category3 = create(:category, name: 'Invisible but associated Category', user: user, visible: false)
          moments_category = MomentsCategory.create(moment_id: moment1.id, category_id: category3.id)
    
          get edit_moment_path(moment1.id)
          expect(response.body).to include(category2.name)
          expect(response.body).not_to include(category1.name)
          expect(response.body).to include(category3.name)
        end

        it 'renders associated strategies in dropdown regardless of visibility status' do
          strategy1 = create(:strategy, name: 'Invisible Strategy', user: user, visible: false)
          strategy2 = create(:strategy, name: 'Visible Strategy', user: user, visible: true)
          strategy3 = create(:strategy, name: 'Invisible but associated Strategy', user: user, visible: true)
          moments_strategy = MomentsStrategy.create(moment_id: moment1.id, strategy_id: strategy3.id)
    
          get edit_moment_path(moment1.id)
          expect(response.body).to include(strategy2.name)
          expect(response.body).not_to include(strategy1.name)
          expect(response.body).to include(strategy3.name)
        end
      end

      context 'when the moment does not belong to the current user' do
        it 'redirects html requests to the strategy_path' do
          get edit_moment_path(moment2.id)
          expect(response).to redirect_to(moment_path(moment2))
        end

        it 'renders nothing for json requests' do
          headers = { 'ACCEPT' => 'application/json' }
          get edit_moment_path(moment2.id), headers: headers
          expect(response.body).to be_empty
        end
      end      
    end

    context 'when the user is not logged in' do
      before { get edit_moment_path(moment2.id) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#show' do
    before { sign_in user }

    it 'renders template' do
      moment.save!
      get moment_path(moment.id)
      expect(response).to render_template(:show)
    end
  end

  describe '#create' do
    let(:valid_moment_params) { attributes_for(:moment) }

    before { sign_in user }

    def post_create(moment_params)
      post moments_path params: { moment: moment_params }
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
      before { sign_in user }

      context 'when the params are valid' do
        before(:each) do
          patch moment_path(moment.id), params: { moment: valid_moment_params }
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
          patch moment_path(moment.id), params: { moment: invalid_moment_params }
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
        patch moment_path(moment.id)
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let!(:moment) { create(:moment, user: user) }

    context 'when the user is logged in' do
      before { sign_in user }

      it 'destroys the moment' do
        expect { delete moment_path(moment.id) }.to(
          change(Moment, :count).by(-1)
        )
      end

      it 'redirects to the moments path for html requests' do
        delete moment_path(moment.id)
        expect(response).to redirect_to(moments_path)
      end

      it 'responds with no content to json requests' do
        headers = { 'ACCEPT' => 'application/json' }
        delete moment_path(moment.id), headers: headers
        expect(response.body).to be_empty
      end
    end

    context 'when the user is not logged in' do
      before { delete moment_path(moment.id) }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#tagged' do
    let!(:category) { create(:category, user_id: user.id) }
    let!(:mood) { create(:mood, user_id: user.id) }
    let!(:strategy) { create(:strategy, user_id: user.id) }
    let!(:moment) { create(:moment, user_id: user.id, category: [category.id], mood: [mood.id], strategy: [strategy.id]) }

    context 'when the user is logged in' do
      before do
        sign_in user
        headers = { 'ACCEPT' => 'application/json' }
        get tagged_moments_path, params: { page: 1, category_id: category.id, mood_id: mood.id, strategy_id: strategy.id }, headers: headers
      end

      it 'returns a response with the correct path' do
        expect(JSON.parse(response.body)['data'].first['link']).to eq moment_path(moment)
      end
    end

    context 'when the user is not logged in' do
      before do
        headers = { 'ACCEPT' => 'application/json' }
        get tagged_moments_path, params: { page: 1, category_id: category.id, mood_id: mood.id, strategy_id: strategy.id }, headers: headers
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
      get moments_path
      expect(assigns(:react_moments)).to have_key(create_time)
      expect(assigns(:react_moments)[create_time]).to eq(1)
    end
  end
end
