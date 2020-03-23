# frozen_string_literal: true
describe SearchController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) {  create(:user, email: 'bar@email.com') }
  let(:user3) {  create(:user, email: 'foo@email.com', banned: true) }

  describe '#index' do
    context 'when user is logged in' do
      include_context :logged_in_user

      context 'when have passed email' do
        it 'strip passed string' do
          expect_any_instance_of(String).to receive(:strip)
          get :index, params: { search: { email: '  hi@email.com ' } }
          expect(response).to render_template(:index)
        end

        it 'filters by non-banned user email' do
          get :index, params: { search: { email: 'bar@email.com' } }
          expect(assigns(:matching_users)).to include(user2)
          expect(response).to render_template(:index)
        end

        it 'does not filter banned user email' do
          get :index, params: { search: { email: 'foo@email.com' } }
          expect(assigns(:matching_users)).not_to include(user3)
          expect(response).to render_template(:index)
        end

        it 'keeps a reference to the email queried' do
          get :index, params: { search: { email: 'bar@email.com' } }
          expect(assigns(:email_query)).to include('bar@email.com')
          expect(response).to render_template(:index)
        end
      end

      context 'when have no passed email' do
        it 'sets the correct instance variables' do
          get :index, params: { search: {} }
          expect(response).to redirect_to('/allies')
        end
      end
    end

    context 'when user is not logged in' do
      before { get :index, params: { search: {} } }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#posts' do
    context 'when user is logged in' do
      include_context :logged_in_user
      let(:word) { 'passed-word' }

      context 'when there is a searched name' do
        before do
          get(
            :posts,
            format: :html,
            params: { search: { name: word, data_type: data_type } }
          )
        end

        context 'when data_type is moment' do
          let(:data_type) { 'moment' }
          specify do
            expect(response).to redirect_to(moments_path(search: word))
          end
        end

        context 'when data_type is category' do
          let(:data_type) { 'category' }
          specify do
            expect(response).to redirect_to(categories_path(search: word))
          end
        end

        context 'when data_type is mood' do
          let(:data_type) { 'mood' }
          specify { expect(response).to redirect_to(moods_path(search: word)) }
        end

        context 'when data_type is strategy' do
          let(:data_type) { 'strategy' }
          specify do
            expect(response).to redirect_to(strategies_path(search: word))
          end
        end

        context 'when data_type is medication' do
          let(:data_type) { 'medication' }
          specify do
            expect(response).to redirect_to(medications_path(search: word))
          end
        end
      end

      context 'when there is not a searched name' do
        before do
          get(
            :posts,
            format: :html,
            params: { search: { name: '', data_type: data_type } }
          )
        end

        context 'when data_type is moment' do
          let(:data_type) { 'moment' }
          specify { expect(response).to redirect_to(moments_path) }
        end

        context 'when data_type is category' do
          let(:data_type) { 'category' }
          specify { expect(response).to redirect_to(categories_path) }
        end

        context 'when data_type is mood' do
          let(:data_type) { 'mood' }
          specify { expect(response).to redirect_to(moods_path) }
        end

        context 'when data_type is strategy' do
          let(:data_type) { 'strategy' }
          specify { expect(response).to redirect_to(strategies_path) }
        end

        context 'when data_type is medication' do
          let(:data_type) { 'medication' }
          specify { expect(response).to redirect_to(medications_path) }
        end
      end
    end

    context 'when user is not logged in' do
      before { get :index, params: { search: {} } }

      it_behaves_like :with_no_logged_in_user
    end
  end
end
