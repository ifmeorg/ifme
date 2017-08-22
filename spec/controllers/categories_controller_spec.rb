# frozen_string_literal: true

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user1) }
  let(:category) { create(:category, userid: user.id) }
  let(:other_category) { create(:category, userid: user.id + 1) }
  let(:valid_category_params) { attributes_for(:category).merge(userid: user.id) }
  let(:invalid_category_params) { { name: nil, description: nil }}

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

  describe 'GET #new' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'renders the page' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when the user is not logged in' do
      before { get :new }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #edit' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'user is trying to edit a category they created' do
        it 'renders the edit form' do
          get :edit, params: { id: category.id }
          expect(response).to render_template(:edit)
        end
      end
      context 'user is trying to edit a category another user created' do
        it 'redirects to the mood path' do
          get :edit, params: { id: other_category.id }
          expect(response).to redirect_to category_path(other_category)
        end
      end
    end
    context 'when the user is not logged in' do
      before { get :edit, params: { id: category.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #create' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when valid params are supplied' do
        it 'creates a new category' do
          expect { post :create, params: { category: valid_category_params } }
            .to change(Category, :count).by 1
        end
        it 'redirects to the category page' do
          post :create, params: { category: valid_category_params }
          expect(response).to redirect_to category_path(assigns(:category))
        end
      end
      context 'when invalid params are supplied' do

      end
    end
    context 'when the user is not logged in' do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end
  end


end
