# frozen_string_literal: true

describe StrategiesController do
  let(:user) { create(:user) }
  let(:strategy) { create(:strategy, user: user) }

  describe 'GET index' do
    let(:strategy) { create(:strategy, name: 'test', user: user) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when search params are provided' do
        before { get :index, params: { search: 'test' } }

        it 'assigns @strategies' do
          expect(assigns(:strategies)).to eq([strategy])
        end

        it 'renders the index template' do
          expect(response).to render_template('index')
        end
      end

      context 'when no search params are provided' do
        it 'renders the index template' do
          get :index
          expect(response).to render_template('index')
        end
      end

      context 'when request type is JSON' do
        before { get :index, params: { page: 1, id: strategy.id }, format: :json }
        it 'returns a response with the correct path' do
          expect(JSON.parse(response.body)['data'].first['link']).to eq strategy_path(strategy)
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET show' do
    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the strategy exists' do
        before { get :show, params: { id: strategy.id } }

        it 'sets the strategy' do
          expect(assigns(:strategy)).to eq(strategy)
        end

        it 'renders the show template' do
          expect(response).to render_template('show')
        end
      end

      context 'when the strategy does not exist' do
        let(:id) { strategy.id + 1 }

        it 'redirects an html request' do
          get :show, params: { id: id }
          expect(response).to redirect_to(strategies_path)
        end

        it 'renders no content for a json request' do
          get :show, format: 'json', params: { id: id }
          expect(response.body).to be_empty
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :show, params: { id: strategy.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST premade' do
    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the request format is html' do
        it 'redirects to the strategies_path' do
          post :premade
          expect(response).to redirect_to(strategies_path)
        end

        it 'returns status code 204 for json format' do
          post :premade, as: :json
          expect(response).to have_http_status(204)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :premade }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST quick_create' do
    context 'when the user is not logged in' do
      before { post :quick_create }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET new' do
    context 'when the user is logged in' do
      include_context :logged_in_user

      it 'renders the new template' do
        get :new
        expect(response).to render_template('new')
      end
    end

    context 'when the user is not logged in' do
      before { get :new }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET edit' do
    let(:another_user) { create(:user) }
    let!(:strategy1)   { create(:strategy, user: user) }
    let!(:strategy2)   { create(:strategy, user: another_user) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the strategy belongs to the current user' do
        it 'renders the edit template' do
          get :edit, params: { id: strategy1.id }
          expect(response).to render_template('edit')
        end
      end

      context 'when the strategy does not belong to the current user' do
        it 'redirects html requests to the strategy_path' do
          get :edit, params: { id: strategy2.id }
          expect(response).to redirect_to(strategy_path(strategy2))
        end

        it 'renders nothing for json requests' do
          get :edit, format: 'json', params: { id: strategy2.id }
          expect(response.body).to be_empty
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :edit, params: { id: strategy2.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST create' do
    let(:valid_strategy_params) { attributes_for(:strategy) }
    let(:invalid_strategy_params) { valid_strategy_params.merge(name: nil) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the params are valid' do
        let(:strategy_params) { { strategy: valid_strategy_params } }

        it 'creates a new strategy' do
          expect do
            post :create, params: strategy_params
          end.to change(Strategy, :count).by(1)
        end

        it 'redirects to the strategy show page for html requests' do
          post :create, params: strategy_params
          expect(response).to redirect_to(strategy_path(assigns(:strategy)))
        end
      end

      context 'when the params are invalid' do
        let(:strategy_params) { { strategy: invalid_strategy_params } }

        it 'does not create a new strategy' do
          expect { post :create, params: strategy_params }.to_not(
            change(Strategy, :count)
          )
        end

        it 'renders the new template for html requests' do
          post :create, params: strategy_params
          expect(response).to render_template('new')
        end

        it 'responds with a 422 status' do
          post(:create, format: 'json', params: strategy_params)
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
          expect { post :create, params: { strategy: hacked_strategy_params } }
            .to change(Strategy, :count).by(1)
          expect(Strategy.last.user_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :create }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'PATCH update' do
    let!(:strategy) { create(:strategy, user: user) }
    let(:valid_strategy_params)   { { description: 'updated description' } }
    let(:invalid_strategy_params) { { description: nil } }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the params are valid' do
        it 'updates the strategy record' do
          patch :update, params: { id: strategy.id, strategy: valid_strategy_params }
          expect(strategy.reload.description).to eq('updated description')
        end

        it 'redirects to the show page' do
          patch :update, params: { id: strategy.id, strategy: valid_strategy_params }
          expect(response).to redirect_to(strategy_path(strategy))
        end
      end

      context 'when the params are invalid' do
        it 'does not update the record' do
          patch :update, params: { id: strategy.id, strategy: invalid_strategy_params }
          expect(strategy.reload.description).to eq('Test Description')
        end

        it 'renders the edit view' do
          patch :update, params: { id: strategy.id, strategy: invalid_strategy_params }
          expect(response).to render_template('edit')
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        patch :update, params: { id: strategy.id }
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'DELETE destroy' do
    let!(:strategy) { create(:strategy, user: user) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      it 'destroys the strategy' do
        expect { delete :destroy, params: { id: strategy.id } }.to(
          change(Strategy, :count).by(-1)
        )
      end

      it 'redirects to the strategies path for html requests' do
        delete :destroy, params: { id: strategy.id }
        expect(response).to redirect_to(strategies_path)
      end

      it 'responds with no content to json requests' do
        delete :destroy, format: 'json', params: { id: strategy.id }
        expect(response.body).to be_empty
      end
    end

    context 'when the user is not logged in' do
      before { delete :destroy, params: { id: strategy.id } }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#print_reminders' do
    let(:user) { create(:user1) }
    let(:strategy) { create(:strategy, name: 'test', user: user) }

    subject { controller.print_reminders(strategy) }

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
