RSpec.describe SearchController, type: :controller do
  let(:user) { create(:user) }

  let!(:user_two) { create(:user, email: 'foo@email.com') }
  let!(:user_three) { create(:user, email: 'bar@email.com') }

  describe 'GET #index' do
    context 'when user is logged in' do
      include_context :logged_in_user

      it 'renders the correct template' do
        get :index, search: {}

        expect(response).to render_template(:index)
      end

      context 'when have passed email' do
        it 'strip passed string' do
          expect_any_instance_of(String).to receive(:strip)

          get :index, search: { email: '  hi@email.com ' }
        end

        it 'filter by user email' do
          get :index, search: { email: 'bar@email.com' }

          expect(assigns(:matching_users)).to eq([user_three])
        end
      end

      context 'when have no passed email' do
        it 'sets the correct instance variables' do
          get :index, search: { email: '' }

          expect(assigns(:matching_users)).to_not include(user)
        end
      end
    end

    context 'when user is not logged in' do
      before { get :index, search: {} }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #posts' do
    context 'when user is logged in' do
      include_context :logged_in_user
      let(:word) { 'passed-word' }

      context 'when have searched name' do
        it 'data_type as moment' do
          get :posts, format: :html, search: { name: word, data_type: 'moment' }

          expect(response).to redirect_to(moments_path(search: 'passed-word'))
        end

        it 'data_type as category' do
          get :posts, format: :html, search: { name: word, data_type: 'category' }

          expect(response).to redirect_to(categories_path(search: 'passed-word'))
        end

        it 'data_type as mood' do
          get :posts, format: :html, search: { name: word, data_type: 'mood' }

          expect(response).to redirect_to(moods_path(search: 'passed-word'))
        end

        it 'data_type as strategy' do
          get :posts, format: :html, search: { name: word, data_type: 'strategy' }

          expect(response).to redirect_to(strategies_path(search: 'passed-word'))
        end

        it 'data_type as medication' do
          get :posts, format: :html, search: { name: word, data_type: 'medication' }

          expect(response).to redirect_to(medications_path(search: 'passed-word'))
        end
      end

      context 'when have no searched name' do
        it 'data_type as moment' do
          get :posts, format: :html, search: { name: '', data_type: 'moment' }

          expect(response).to redirect_to(moments_path)
        end

        it 'data_type as category' do
          get :posts, format: :html, search: { name: '', data_type: 'category' }

          expect(response).to redirect_to(categories_path)
        end

        it 'data_type as mood' do
          get :posts, format: :html, search: { name: '', data_type: 'mood' }

          expect(response).to redirect_to(moods_path)
        end

        it 'data_type as strategy' do
          get :posts, format: :html, search: { name: '', data_type: 'strategy' }

          expect(response).to redirect_to(strategies_path)
        end

        it 'data_type as medication' do
          get :posts, format: :html, search: { name: '', data_type: 'medication' }

          expect(response).to redirect_to(medications_path)
        end
      end
    end

    context 'when user is not logged in' do
      before { get :index, search: {} }

      it_behaves_like :with_no_logged_in_user
    end
  end
end
