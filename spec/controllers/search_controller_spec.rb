RSpec.describe SearchController, type: :controller do
  let(:user) { create(:user) }

  describe '#index' do
    before { get :index }

    context 'when user is logged in' do
      include_context :logged_in_user

      it 'renders the correct template' do
        expect(response).to render_template(:index)
      end

      context 'when have passed email' do
        it 'sets the correct instance variables' do

        end
      end

      context 'when have no passed email' do
        it 'sets the correct instance variables' do
        end
      end
    end

    context 'when user is not logged in' do
      it_behaves_like :with_no_logged_in_user
    end
  end
end
