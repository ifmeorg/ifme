# frozen_string_literal: true

describe "Care Plan", type: :request do
  describe '#index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'response is successful' do
        get care_plan_path
        expect(response).to be_successful
      end

      context 'when there are bookmarked strategies' do
        let!(:strategy) { create(:strategy, user: user, bookmarked: true) }

        it 'assigns bookmarked_strategies' do
          get care_plan_path
          expect(response.body).to include(strategy.name)
        end
      end

      context 'when there are bookmarked moments' do
        let!(:moment_bm) { create(:moment, user: user, bookmarked: true) }
        let!(:moment_no_bm) { create(:moment, name: 'Not bookmarked', user: user) }

        it 'assigns bookmarked_strategies' do
          get care_plan_path
          expect(response.body).to include(moment_bm.name)
          expect(response.body).to_not include(moment_no_bm.name)
        end
      end
    end

    context 'when user is not signed in' do
      before { get care_plan_path }

      it 'does not render a page' do
        expect(response).not_to be_successful
      end

      it 'is redirected to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
