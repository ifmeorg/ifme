# frozen_string_literal: true

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user1) }
  let(:category) { create(:category, userid: user.id) }
  let(:other_category) { create(:category, userid: user.id + 1) }

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

  describe 'GET #show' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when the user created the category' do
        before { get :show, params: { id: category.id } }
        it 'passes the edit link and tooltip text to the template' do
          expect(assigns(:page_edit)).to eq edit_category_path(category)
          expect(assigns(:page_tooltip)).to eq I18n.t('categories.edit_category')
        end
        it 'renders the page' do
          expect(response).to render_template(:show)
        end
      end
      context "when the user didn't create the category" do
        before { get :show, params: { id: other_category.id } }
        it 'redirects to the categories index page' do
          expect(response).to redirect_to categories_path
        end
      end
    end

    context 'when the user is not logged in' do
      before { get :show, params: { id: category.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
