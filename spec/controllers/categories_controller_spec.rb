# frozen_string_literal: true

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user1) }
  let(:category) { create(:category, user_id: user.id) }
  let(:other_category) { create(:category, user_id: user.id + 1) }
  let(:valid_category_params) { attributes_for(:category).merge(user_id: user.id) }
  let(:invalid_category_params) { { name: nil, description: nil } }

  describe 'GET #index' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      before { get :index }
      it 'sets the categories and page tooltip ivar' do
        expect(assigns(:categories)).to eq [category]
        expect(assigns(:page_new)).to eq I18n.t('categories.new')
      end
      it 'renders the page' do
        expect(response).to render_template(:index)
      end
    end

    context 'when request type is JSON' do
      include_context :logged_in_user
      before { get :index, params: { page: 1, id: category.id }, format: :json }
      it 'returns a response with the correct path' do
        expect(JSON.parse(response.body)['data'].first['link']).to eq category_path(category)
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
        it 'redirects to the category path' do
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
        before { post :create, params: { category: invalid_category_params } }
        it 're-renders the creation form' do
          expect(response).to render_template(:new)
        end
        it 'adds errors to the category ivar' do
          expect(assigns(:category).errors).not_to be_empty
        end
      end

      context 'when the user_id is hacked' do
        it 'creates a new category, ignoring the user_id parameter' do
          # passing a user_id isn't an error, but it shouldn't
          # affect the owner of the created item
          another_user = create(:user2)
          hacked_category_params =
            valid_category_params.merge(user_id: another_user.id)
          expect { post :create, params: { category: hacked_category_params } }
            .to change(Category, :count).by(1)
          expect(Category.last.user_id).to eq(user.id)
        end
      end
    end
    context 'when the user is not logged in' do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #premade' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'creates 4 premade categories' do
        expect { post :premade }.to change(Category, :count).by 4
      end
      it 'redirects to the category index page' do
        post :premade
        expect(response).to redirect_to categories_path
      end
    end
    context 'when the user is not logged in' do
      before { post :premade }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'PATCH/PUT #update' do
    let(:valid_update_params) { { name: 'updated name' } }
    let(:invalid_update_params) { { name: nil } }

    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when valid params are supplied' do
        before { patch :update, params: { id: category.id, category: valid_update_params } }
        it 'updates the category' do
          expect(category.reload.name).to eq 'updated name'
        end
        it 'redirects to the category page' do
          expect(response).to redirect_to category_path(assigns(:category))
        end
      end
      context 'when invalid params are supplied' do
        before { patch :update, params: { id: category.id, category: invalid_update_params } }
        it 're-renders the edit form' do
          expect(response).to render_template(:edit)
        end
        it 'adds errors to the category ivar' do
          expect(assigns(:category).errors).not_to be_empty
        end
      end
    end
    context 'when the user is not logged in' do
      before { patch :update, params: { id: category.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'DELETE #destroy' do
    let!(:moment) { create(:moment, user_id: user.id, category: [category.id]) }
    let!(:strategy) { create(:strategy, comment: false, name: 'a', description: 'b', user_id: user.id, category: [category.id]) }

    context 'when the user is logged in' do
      include_context :logged_in_user
      it 'deletes the category' do
        expect { delete :destroy, params: { id: category.id } }
          .to change(Category, :count).by(-1)
      end
      it 'removes categories from existing moments' do
        delete :destroy, params: { id: category.id }
        expect(moment.reload.category).not_to include(category.id)
      end
      it 'removes categories from existing strategies' do
        delete :destroy, params: { id: category.id }
        expect(strategy.reload.category).not_to include(category.id)
      end
      it 'redirects to the category index page' do
        delete :destroy, params: { id: category.id }
        expect(response).to redirect_to categories_path
      end
    end
    context 'when the user is not logged in' do
      before { delete :destroy, params: { id: category.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #quick_create' do
    context 'when the user is logged in' do
      include_context :logged_in_user
      context 'when valid params are supplied' do
        it 'creates the category' do
          expect { post :quick_create, params: { category: valid_category_params } }
            .to change(Category, :count).by 1
        end
        it 'responds with a checkbox in json format' do
          post :quick_create, params: { category: valid_category_params }
          expect(response.body).to eq({
            success: true,
            id: Category.last.id,
            name: Category.last.name,
            slug: Category.last.slug
          }.to_json)
        end
      end
      context 'when invalid params are supplied' do
        it 'responds with an error in json format' do
          post :quick_create, params: { category: invalid_category_params }
          expect(response.body).to eq({ success: false }.to_json)
        end
      end
    end
    context 'when the user is not logged in' do
      before { post :quick_create }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
