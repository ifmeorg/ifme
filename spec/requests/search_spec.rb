# frozen_string_literal: true

describe 'Search', type: :request do
  let(:user) { create(:user) }

  describe '#index' do
    context 'when user is logged in' do
      before { sign_in user }

      context 'when have passed email' do
        it 'renders page' do
          get search_index_path, params: { search: { email: 'bar@email.com' } }
          expect(response).to be_successful
        end

        it 'filters by non-banned user email' do
          nonbanned_user = create(:user, email: 'bar@email.com',
                                         name: 'user 2 name')
          get(search_index_path,
              params: { search: { email: nonbanned_user.email } })
          expect(response.body).to include(nonbanned_user.name)
        end

        it 'does not filter banned user email' do
          banned_user = create(:user, email: 'foo@email.com',
                                      banned: true,
                                      name: 'user 3 name')
          get(search_index_path,
              params: { search: { email: banned_user.email } })
          expect(response.body).not_to include(banned_user.name)
        end

        it 'keeps a reference to the email queried' do
          get(search_index_path,
              params: { search: { email: 'bar@email.com' } })
          expect(response.body).to include('bar@email.com')
        end
      end

      context 'when have no passed email' do
        it 'sets the correct instance variables' do
          get search_index_path, params: { search: {} }
          expect(response).to redirect_to('/allies')
        end
      end
    end

    context 'when user is not logged in' do
      before { get search_index_path, params: { search: {} } }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#posts' do
    context 'when user is logged in' do
      before { sign_in user }
      let(:word) { 'passed-word' }

      context 'when there is a searched name' do
        before do
          get(
            posts_search_index_path,
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
            posts_search_index_path,
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
      before do
        get(
          posts_search_index_path,
          params: { search: { name: 'word', data_type: 'data_type' } }
        )
      end

      it_behaves_like :with_no_logged_in_user
    end
  end
end
