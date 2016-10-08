RSpec.describe SearchController, type: :controller do
  let(:user) { create(:user) }

  let!(:user_two) { create(:user, email: 'foo@email.com') }
  let!(:user_three) { create(:user, email: 'bar@email.com') }

  describe '#index' do
    context 'when user is logged in' do
      include_context :logged_in_user

      it 'renders the correct template' do
        get :index, search: { }

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
      before { get :index, search: { } }

      it_behaves_like :with_no_logged_in_user
    end
  end
end
