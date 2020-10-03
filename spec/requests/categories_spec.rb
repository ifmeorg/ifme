RSpec.describe 'Categories', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user_id: user.id) }
  describe '#index' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'sets the categories and page tooltip ivar' do
        params = { page: 1, id: category.id }
        headers = { "ACCEPT" => "application/json" }
        get categories_path, headers: headers, params: params
        expect(JSON.parse(response.body)['data'].first['name']).to eq(category.name)
      end

      it 'renders the page' do
        get categories_path
        expect(response).to render_template('index')
      end
    end

    context 'when the user is not logged in' do
      before { get categories_path }
      it_behaves_like :with_no_logged_in_user
    end

  describe '#show' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when the user created the category' do
        before { get category_path(category.id) }

        it 'renders the page' do
          expect(response).to render_template('show')
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

  end
end
