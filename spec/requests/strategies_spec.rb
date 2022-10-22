# frozen_string_literal: true

describe 'Strategy', type: :request do
  let(:user) { create(:user) }
  let(:strategy) { create(:strategy, user: user) }

  describe '#index' do
    let(:strategy) { create(:strategy, name: 'test', user: user) }

    context 'when the user is logged in' do
      before { sign_in user}

      context 'when search params are provided' do
        it 'displays the correct strategies' do
          get strategies_path, params: { search: 'test' }
          expect(response.body).to include(strategy.name)
        end

        it 'renders the index template' do
          get strategies_path
          expect(response).to render_template('index')
        end
      end

      context 'when no search params are provided' do
        it 'renders the index template' do
          get strategies_path
          expect(response).to render_template('index')
        end
      end

      context 'when request type is JSON' do
        it 'returns a response with the correct path' do
          headers = { "ACCEPT" => "application/json" }
          params = { page: 1, id: strategy.id }
          get strategies_path, params: params, headers: headers
          expect(JSON.parse(response.body)['data'].first['link']).to eq strategy_path(strategy)
        end
      end
    end

    context 'when the user is not logged in' do
      before { get strategies_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#show' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the strategy exists' do
        it 'sets the strategy' do
          get strategy_path(strategy)
          expect(response.body).to include(strategy.name)
        end

        it 'renders the show template' do
          get strategy_path(strategy)
          expect(response).to render_template('show')
        end
      end

      context 'when the strategy does not exist' do
        it 'redirects an html request' do
          get strategy_path(strategy.id + 1)
          expect(response).to redirect_to(strategies_path)
        end

        it 'renders no content for a json request' do
          headers = { "ACCEPT" => "application/json" }
          get strategy_path(strategy.id + 1), headers: headers
          expect(response.body).to be_empty
        end
      end
    end

    context 'when the user is not logged in' do
      before { get strategies_path, params: { id: strategy.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#premade' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the request format is html' do
        it 'redirects to the strategies_path' do
          post premade_strategies_path
          expect(response).to redirect_to(strategies_path)
        end

        it 'returns status code 204 for json format' do
          headers = { "ACCEPT" => "application/json" }
          post premade_strategies_path, headers: headers
          expect(response).to have_http_status(204)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post premade_strategies_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#quick_create' do
    context 'when the user is not logged in' do
      before { post quick_create_strategies_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#new' do
    context 'when the user is logged in' do
      before { sign_in user }
      it 'renders the new template' do
        get new_strategy_path
        expect(response).to render_template('new')
      end
      
      it 'does not show not_visible category in dropdown' do
        category1 = create(:category, name: 'Invisible Category', user: user, visible: false)
        category2 = create(:category, name: 'Visible Category', user: user, visible: true)
  
        get new_strategy_path
        expect(response.body).to include(category2.name)
        expect(response.body).not_to include(category1.name)
      end
    end

    context 'when the user is not logged in' do
      before { get new_strategy_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#edit' do
    let(:another_user) { create(:user) }
    let!(:strategy1)   { create(:strategy, user: user) }
    let!(:strategy2)   { create(:strategy, user: another_user) }

    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the strategy belongs to the current user' do
        it 'renders the edit template' do
          get edit_strategy_path(strategy1), params: { id: strategy1.id }
          expect(response).to render_template('edit')
        end
      end

      it 'renders associated category in dropdown regardless of visibility status' do
        category1 = create(:category, name: 'Invisible Category', user: user, visible: false)
        strategy_category = StrategiesCategory.create(category_id: category1.id, strategy_id: strategy1.id)
        category2 = create(:category, name: 'Visible Category', user: user, visible: true)
        category3 = create(:category, name: 'Invisible Category 3', user: user, visible: false)
  
        get edit_strategy_path(strategy1), params: { id: strategy1.id }
        expect(response.body).to include(category2.name)
        expect(response.body).to include(category1.name)
        expect(response.body).not_to include(category3.name)
      end

      context 'when the strategy does not belong to the current user' do
        it 'redirects html requests to the strategy_path' do
          get edit_strategy_path(strategy2), params: { id: strategy2.id }
          expect(response).to redirect_to(strategy_path(strategy2))
        end

        it 'renders nothing for json requests' do
          headers = { "ACCEPT" => "application/json" }
          params = { id: strategy2.id }
          get edit_strategy_path(strategy2),  params: params, headers: headers
          expect(response.body).to be_empty
        end
      end
    end

    context 'when the user is not logged in' do
      before { get new_strategy_path, params: { id: strategy2.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#create' do
    let(:valid_strategy_params) { attributes_for(:strategy) }
    let(:invalid_strategy_params) { valid_strategy_params.merge(name: nil) }

    context 'when the user is logged in' do
      before { sign_in user }
      context 'when the params are valid' do
        let(:strategy_params) { { strategy: valid_strategy_params } }

        it 'creates a new strategy' do
          expect do
            post strategies_path, params: strategy_params
          end.to change(Strategy, :count).by(1)
        end

        it 'redirects to the strategy show page for html requests' do
          post strategies_path, params: strategy_params
          expect(response).to redirect_to(strategy_path(Strategy.last))
        end
      end

      context 'when the params are invalid' do
        let(:strategy_params) { { strategy: invalid_strategy_params } }

        it 'does not create a new strategy' do
          expect { post strategies_path, params: strategy_params }.to_not(
            change(Strategy, :count)
          )
        end

        it 'renders the new template for html requests' do
          post strategies_path, params: strategy_params
          expect(response).to render_template('new')
        end

        it 'responds with a 422 status' do
          headers = { "ACCEPT" => 'application/json'}
          post strategies_path, params: strategy_params, headers: headers
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when the user_id is hacked' do
        let(:another_user) { create(:user) }

        it 'creates a new strategy, ignoring the user_id parameter' do
          # passing a user_id isn't an error, but it shouldn't
          # affect the owner of the created item
          hacked_strategy_params =
            valid_strategy_params.merge(user_id: another_user.id)
          expect { post strategies_path, params: { strategy: hacked_strategy_params } }
            .to change(Strategy, :count).by(1)
          expect(Strategy.last.user_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post strategies_path }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#update' do
    let!(:strategy) { create(:strategy, user: user) }
    let(:valid_strategy_params)   { { description: 'updated description' } }
    let(:invalid_strategy_params) { { description: nil } }

    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the params are valid' do
        it 'updates the strategy record' do
          put strategy_path(strategy), params: { strategy_id: strategy.id, strategy: valid_strategy_params }
          expect(strategy.reload.description).to eq('updated description')
        end

        it 'redirects to the show page' do
          put strategy_path(strategy), params: { strategy_id: strategy.id, strategy: valid_strategy_params }
          expect(response).to redirect_to(strategy_path(strategy))
        end
      end

      context 'when the params are invalid' do
        it 'does not update the record' do
          put strategy_path(strategy), params: { strategy_id: strategy.id, strategy: invalid_strategy_params }
          expect(strategy.reload.description).to eq('Test Description')
        end

        it 'renders the edit view' do
          put strategy_path(strategy), params: { strategy_id: strategy.id, strategy: invalid_strategy_params }
          expect(response).to render_template('edit')
        end
      end
    end

    context 'when the user is not logged in' do
      before { put strategy_path(strategy) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    context 'when strategy has no reminders' do
      let!(:strategy) { create(:strategy, user: user) }

      context 'when the user is logged in' do
        before { sign_in user }

        it 'destroys the strategy' do
          expect { delete strategy_path(strategy), params: { id: strategy.id } }.to(
            change(Strategy, :count).by(-1)
          )
        end

        it 'redirects to the strategies path for html requests' do
          delete strategy_path(strategy), params: { id: strategy.id }
          expect(response).to redirect_to(strategies_path)
        end

        it 'responds with no content to json requests' do
          headers = { "ACCEPT" => 'application/json'}
          delete strategy_path(strategy), params: { id: strategy.id }, headers: headers
          expect(response.body).to be_empty
        end
      end

      context 'when the user is not logged in' do
        before { delete strategy_path(strategy), params: { id: strategy.id } }

        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'when strategy has reminders' do
      let!(:strategy) do
        create(:strategy, :with_daily_reminder, user: user)
      end

      context 'when the user is logged in' do
        before { sign_in user}

        it 'destroys the strategy' do
          expect(PerformStrategyReminder.active.count).to eq(1)
          expect { delete strategy_path(strategy), params: { id: strategy.id } }.to(
            change(Strategy, :count).by(-1)
          )
          expect(PerformStrategyReminder.active.count).to eq(0)
        end

        it 'redirects to the strategies path for html requests' do
          delete strategy_path(strategy), params: { id: strategy.id }
          expect(response).to redirect_to(strategies_path)
        end

        it 'responds with no content to json requests' do
          headers = { "ACCEPT" => 'application/json'}
          delete strategy_path(strategy), params: { id: strategy.id }, headers: headers
          expect(response.body).to be_empty
        end
      end

      context 'when the user is not logged in' do
        before { delete strategy_path(strategy), params: { id: strategy.id } }

        it_behaves_like :with_no_logged_in_user
      end
    end
  end



  describe '#tagged' do
    let!(:category) { create(:category, user_id: user.id) }
    let!(:strategy) { create(:strategy, user_id: user.id, category: [category.id]) }

    context 'when the user is logged in' do
      it 'returns a response with the correct path' do
        sign_in user
        headers = { "ACCEPT" => 'application/json'}
        get tagged_strategies_path, params: { page: 1, category_id: category.id }, headers: headers
        expect(JSON.parse(response.body)['data'].first['link']).to eq strategy_path(strategy)
      end
    end

    context 'when the user is not logged in' do
      it 'returns a no_content status' do
        headers = { "ACCEPT" => 'application/json'}
        get tagged_strategies_path, params: { page: 1, category_id: category.id }, headers: headers
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe '#print_reminders' do
    let(:user) { create(:user1) }
    let(:strategy) { create(:strategy, name: 'test', user: user) }

    subject { StrategiesController.new.print_reminders(strategy) }

    describe 'when strategy has no reminders' do
      let(:strategy) { create(:strategy, user: user) }

      it { is_expected.to eq('') }
    end

    describe 'when strategy has daily reminder' do
      let(:strategy) do
        create(:strategy, :with_daily_reminder, user: user)
      end

      it 'prints the reminders' do
        expect(subject).to(
          eq(
            '<div>' \
            '<i class="fa fa-bell smallMarginRight"></i>' \
            'Daily reminder email</div>'
          )
        )
      end
    end
  end
end
