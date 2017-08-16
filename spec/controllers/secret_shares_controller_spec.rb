# frozen_string_literal: true

describe SecretSharesController, type: :controller do
  let(:moment) { create(:moment, :with_user) }
  describe 'POST create' do
    context 'signed in as creator of the moment' do
      before do
        sign_in moment.user
        post :create, moment: moment
      end

      it 'Creates Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).not_to be_nil
      end
    end

    context 'not signed in' do
      before do
        post :create, moment: moment
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
    let(:moment) { create(:moment, :with_user, :with_secret_share) }
    before { get :show, id: moment.secret_share_identifier }

    specify do
      expect(response).to render_template(:show)
    end
  end
end
