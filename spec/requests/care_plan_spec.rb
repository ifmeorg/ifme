# frozen_string_literal: true

RSpec.describe "Care Plan", type: :request do
  describe '#index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      before do
        sign_in user
        get care_plan_path
      end

      it 'renders template' do
        expect(response).to be_successful
      end

      it 'response is successful' do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('text/html; charset=utf-8')
        expect(response).to be_successful
      end

      context 'when there are bookmared strategies' do
        let!(:strategy) { create(:strategy, user: user, bookmarked: true) }
        before { get care_plan_path }

        it 'assigns @bookmarked_strategies' do
          expect(response.body).to include(strategy.name)
        end
      end
    end
    context 'when user is not signed in' do
      before { get care_plan_path }

      it 'does not render a page' do
        expect(response).not_to be_successful
      end

      it 'is redirected to sign in' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
