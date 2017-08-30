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

    context 'signed in as another user' do
      before do
        new_user = create(:user)
        sign_in new_user
      end
      specify { expect { post :create, params: { moment: moment } }.to raise_error(ActiveRecord::RecordNotFound) }
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
    context 'secret share is valid' do
      before { get :show, params: { id: moment.secret_share_identifier } }
      let(:moment) { create(:moment, :with_user, :with_secret_share) }
      specify { expect(response).to render_template(:show) }
    end
    context 'no secret share' do
      specify do
        expect{ get :show, params: { id: 'foobar' } }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'DELETE' do
    let(:moment) { create(:moment, :with_user, :with_secret_share) }
    context 'signed in as creator of the moment' do
      before do
        sign_in moment.user
        delete :destroy, params: { id: moment.secret_share_identifier }
      end

      it 'Deletes Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).to be_nil
      end
    end

    context 'signed in as another user' do
      before do
        new_user = create(:user)
        sign_in new_user
      end
      specify { expect { delete :destroy, params: { id: moment.secret_share_identifier } }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'not signed in' do
      before do
        delete :destroy, params: { id: moment.secret_share_identifier }
      end

      it 'does not delete Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).not_to be_nil
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
