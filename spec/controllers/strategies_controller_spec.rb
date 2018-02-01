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
          expect(response.body).to eq('')
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :show, params: { id: strategy.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST comment' do
    let(:comment) do
      build(:comment, comment_by: user.id, commentable_type: 'strategy')
    end
    let(:valid_comment_params) do
      comment.attributes.merge(
        'commentable_id' => strategy.id, 'visibility' => 'all'
      )
    end
    let(:invalid_comment_params) { comment.attributes }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment is saved' do
        it 'responds with an OK status' do
          post :comment, params: valid_comment_params
          expect(response.status).to eq(200)
        end
      end

      context 'when the comment is not saved' do
        it 'responds with json no_save: true' do
          post :comment, params: invalid_comment_params
          expect(response.body).to eq({no_save: true}.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :comment }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET delete_comment' do
    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment exists' do
        let!(:comment) do
          create(
            :comment,
            comment_by: user.id,
            commentable_id: strategy.id,
            visibility: 'all'
          )
        end

        context 'when the comment belongs to the current_user' do
          it 'destroys the comment' do
            expect { get :delete_comment, params: { commentid: comment.id } }
              .to change(Comment, :count).by(-1)
          end

          it 'renders nothing' do
            get :delete_comment, params: { commentid: comment.id }
            expect(response.body).to eq('')
          end
        end

        context 'when the strategy belongs to the current_user' do
          it 'destroys the comment' do
            expect { get :delete_comment, params: { commentid: comment.id } }
              .to change(Comment, :count).by(-1)
          end

          it 'renders nothing' do
            comment
            get :delete_comment, params: { commentid: 1 }

            expect(response.body).to eq('')
          end
        end
      end

      context 'when the comment does not exist' do
        it 'renders nothing' do
          get :delete_comment, params: { commentid: 1 }
          expect(response.body).to eq('')
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :delete_comment }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST premade' do
    let(:user) { create(:user, id: 1) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the request format is html' do
        it 'redirects to the strategies_path' do
          post :premade
          expect(response).to redirect_to(strategies_path)
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
    let(:user) { create(:user, id: 1) }

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
    let(:user)        { create(:user, id: 1) }
    let!(:strategy1)  { create(:strategy, userid: 1, id: 1) }
    let!(:strategy2)  { create(:strategy, userid: 2, id: 2) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the strategy belongs to the current user' do
        it 'renders the edit template' do
          get :edit, params: { id: 1 }
          expect(response).to render_template('edit')
        end
      end

      context 'when the strategy does not belong to the current user' do
        it 'redirects html requests to the strategy_path' do
          get :edit, params: { id: 2 }
          expect(response).to redirect_to(strategy_path(strategy2))
        end

        it 'renders nothing for json requests' do
          get :edit, format: 'json', params: { id: 2 }
          expect(response.body).to eq('')
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :edit, params: { id: 2 } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST create' do
    let(:user) { create(:user, id: 1) }
    let(:another_user) { create(:user, id: 2) }
    let(:valid_strategy_params) { FactoryGirl.attributes_for(:strategy) }
    let(:invalid_strategy_params) { valid_strategy_params.merge(name: nil) }
    let(:hacked_strategy_params) { valid_strategy_params.merge(userid: another_user.id) }

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

        it 'redirects to the strategy show' do
          post :create, params: strategy_params
          expect(response.status).to eq(302)
          expect(response.location).to eq(strategy_url(assigns(:strategy)))
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
          expect(response.status).to eq(422)
        end
      end

      context 'when the userid is hacked' do
        let(:strategy_params) { { strategy: hacked_strategy_params } }

        it 'creates a new strategy' do
          expect do
            post :create, params: strategy_params
          end.to change(Strategy, :count).by(1)
        end

        it 'uses the logged-in userid, not the one in the params' do
          post :create, params: strategy_params
          expect(Strategy.last.userid).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :create }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'PATCH update' do
    let(:user)      { create(:user, id: 1) }
    let!(:strategy) { create(:strategy, userid: 1, id: 1) }
    let(:valid_strategy_params)   { {description: 'updated description'} }
    let(:invalid_strategy_params) { {description: nil} }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the params are valid' do
        it 'updates the strategy record' do
          patch :update, params: { id: 1, strategy: valid_strategy_params }
          expect(strategy.reload.description).to eq('updated description')
        end

        it 'redirects to the show page' do
          patch :update, params: { id: 1, strategy: valid_strategy_params }
          expect(response).to redirect_to(strategy_path(strategy))
        end
      end

      context 'when the params are invalid' do
        it 'does not update the record' do
          patch :update, params: { id: 1, strategy: invalid_strategy_params }
          expect(strategy.reload.description).to eq('Test Description')
        end

        it 'renders the edit view' do
          patch :update, params: { id: 1, strategy: invalid_strategy_params }
          expect(response).to render_template('edit')
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        patch :update, params: { id: 1 }
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'DELETE destroy' do
    let(:user)      { create(:user, id: 1) }
    let!(:strategy) { create(:strategy, userid: 1, id: 1) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      it 'destroys the strategy' do
        expect { delete :destroy, params: { id: 1 } }.to(
          change(Strategy, :count).by(-1)
        )
      end

      it 'redirects to the strategies path for html requests' do
        delete :destroy, params: { id: 1 }
        expect(response).to redirect_to(strategies_path)
      end

      it 'responds with no content to json requests' do
        delete :destroy, format: 'json', params: { id: 1 }
        expect(response.body).to eq('')
      end
    end

    context 'when the user is not logged in' do
      before { delete :destroy, params: { id: 1 } }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#print_reminders' do
    let(:user) { FactoryGirl.create(:user1) }
    let(:strategy)     { create(:strategy, name: 'test', userid: user.id) }

    subject { controller.print_reminders(strategy) }

    describe 'when strategy has no reminders' do
      let(:strategy) { FactoryGirl.create(:strategy, userid: user.id) }

      it { is_expected.to eq('') }
    end

    describe 'when strategy has daily reminder' do
      let(:strategy) do
        FactoryGirl.create(:strategy, :with_daily_reminder, userid: user.id)
      end

      it 'prints the reminders' do
        expect(subject).to(
          eq(
            '<div class="small_margin_top">' \
            '<i class="fa fa-bell small_margin_right"></i>' \
            'Daily reminder email</div>'
          )
        )
      end
    end
  end
end
