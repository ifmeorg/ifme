# frozen_string_literal: true

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user1) }

  describe 'GET #index' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'renders the page' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when the user is not logged in' do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
