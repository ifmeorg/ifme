# frozen_string_literal: true

describe SecretSharesController, type: :controller do
  describe 'POST create' do
    let(:moment) { create(:moment, :with_user) }
    context 'signed in as creator of the moment' do
      before do
        sign_in moment.user
        post :create, params: { moment: moment }
      end

      it 'Creates Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).not_to be_nil
      end
    end

    context 'not signed in' do
      before do
        post :create, params: { moment: moment }
      end

      it 'does not create Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).to be_nil
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET show' do
    before { get :show, params: { id: moment.secret_share_identifier } }

    context 'secret share has expired' do
      let(:moment) { create(:moment, :with_user, :with_secret_share, secret_share_expires_at: 1.day.ago) }
      specify { expect(response.status).to eq(404) }
    end

    context 'secret share is valid' do
      let(:moment) { create(:moment, :with_user, :with_secret_share) }
      specify { expect(response).to render_template(:show) }
    end
  end
end
