# frozen_string_literal: true

describe 'Categories', type: :request do
  let(:user) { create(:user) }
  let(:user1) { create(:user1) }
  let(:category) { create(:category, user_id: user.id) }

  describe '#index' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'sets the categories and page tooltip ivar' do
        params = { page: 1, id: category.id }
        headers = { 'ACCEPT' => 'application/json' }
        get categories_path, headers: headers, params: params
        expect(JSON.parse(response.body)['data'].first['name']).to eq(
          category.name
        )
      end

      it 'renders the page' do
        get categories_path
        expect(response).to be_successful
      end
    end

    context 'when the user is not logged in' do
      before { get categories_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#show' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the user created the category' do
        before { get category_path(category.id) }

        it 'renders the page' do
          expect(response).to be_successful
        end
      end

      context "when the user didn't create the category" do
        before { get category_path(category.id + 1) }

        it 'redirects to the categories index page' do
          expect(response).to redirect_to categories_path
        end
      end
    end

    context 'when the user is not logged in' do
      before { get category_path(category.id) }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#new' do
    context 'when the user is logged in' do
      before do
        sign_in user
        get new_category_path
      end

      it 'renders the page' do
        expect(response).to be_successful
      end
    end

    context 'when the user is not logged in' do
      before { get new_category_path }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#edit' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'user is trying to edit a category they created' do
        before { get edit_category_path(category.id) }

        it 'renders the edit form' do
          expect(response).to be_successful
        end
      end

      context 'user is trying to edit a category another user created' do
        let(:other_category) { create(:category, user_id: user1.id) }
        before { get edit_category_path(other_category.id) }

        it 'redirects to the category path' do
          expect(response).to redirect_to category_path(other_category)
        end
      end
    end

    context 'when the user is not logged in' do
      before { get edit_category_path(category.id) }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#create' do
    context 'when the user is logged in' do
      let(:valid_category_params) do
        attributes_for(:category).merge(user_id: user.id)
      end
      before { sign_in user }

      context 'when valid params are supplied' do
        before do
          post categories_path, params: { category: valid_category_params }
        end

        it 'creates a new category' do
          expect {
            post categories_path, params: { category: valid_category_params }
          }.to change(Category, :count).by 1
        end

        it 'redirects to the category page' do
          expect(response).to redirect_to category_path(
                        Category.last.name.gsub(' ', '-').downcase
                      )
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_category_params) { { name: nil, description: nil } }
        before do
          post categories_path, params: { category: invalid_category_params }
        end
        it 're-renders the creation form' do
          expect(response).to be_successful
        end
      end

      context 'when the user_id is hacked' do
        it 'creates a new category, ignoring the user_id parameter' do
          # passing a user_id isn't an error, but it shouldn't
          # affect the owner of the created item
          another_user = create(:user2)
          hacked_category_params =
            valid_category_params.merge(user_id: another_user.id)
          expect {
            post categories_path, params: { category: hacked_category_params }
          }.to change(Category, :count).by(1)
          expect(Category.last.user_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post categories_path }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#premade' do
    context 'when the user is logged in' do
      before do
        sign_in user
        post premade_categories_path
      end

      it 'creates 4 premade categories' do
        expect { post premade_categories_path }.to change(Category, :count).by 4
      end

      it 'redirects to the category index page' do
        expect(response).to redirect_to categories_path
      end
    end

    context 'when the user is not logged in' do
      before { post premade_categories_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#update' do
    let(:valid_update_params) { { name: 'updated name' } }

    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        before do
          patch category_path(category),
                params: { id: category.id, category: valid_update_params }
        end

        it 'updates the category' do
          expect(category.reload.name).to eq 'updated name'
        end

        it 'redirects to the category page' do
          expect(response).to redirect_to category_path(
                        Category.last.name.gsub(' ', '-').downcase
                      )
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_update_params) { { name: nil } }

        before do
          patch category_path(category),
                params: { id: category.id, category: invalid_update_params }
        end

        it 're-renders the edit form' do
          expect(response).to be_successful
        end
      end
    end

    context 'when the user is not logged in' do
      before { patch category_path(category) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let!(:moment) { create(:moment, user_id: user.id, category: [category.id]) }
    let!(:strategy) do
      create(
        :strategy,
        comment: false,
        name: 'a',
        description: 'b',
        user_id: user.id,
        category: [category.id]
      )
    end

    context 'when the user is logged in' do
      before { sign_in user }

      it 'deletes the category' do
        expect {
          delete category_path(category), params: { id: category.id }
        }.to change(Category, :count).by(-1)
      end

      context 'when the category is deleted' do
        before { delete category_path(category), params: { id: category.id } }

        it 'removes categories from existing moments' do
          expect(moment.reload.categories).not_to include(category)
        end

        it 'removes categories from existing strategies' do
          expect(strategy.reload.categories).not_to include(category.id)
        end

        it 'redirects to the category index page' do
          expect(response).to redirect_to categories_path
        end
      end
    end

    context 'when the user is not logged in' do
      before { delete category_path(category), params: { id: category.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#quick_create' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        let(:valid_category_params) do
          attributes_for(:category).merge(user_id: user.id)
        end
        before do
          post quick_create_categories_path,
               params: { category: valid_category_params }
        end

        it 'creates the category' do
          expect {
            post quick_create_categories_path,
                 params: { category: valid_category_params }
          }.to change(Category, :count).by 1
        end

        it 'responds with a checkbox in json format' do
          expect(response.body).to eq(
            {
              success: true,
              id: Category.last.id,
              name: Category.last.name,
              slug: Category.last.slug
            }.to_json
          )
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_category_params) { { name: nil, description: nil } }
        before do
          post quick_create_categories_path,
               params: { category: invalid_category_params }
        end

        it 'responds with an error in json format' do
          expect(response.body).to eq({ success: false }.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post quick_create_categories_path }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
