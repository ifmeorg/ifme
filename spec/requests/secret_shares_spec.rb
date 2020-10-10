# frozen_string_literal: true

describe 'SecretShares', type: :request do
  def raise_record_not_found
    raise_error(ActiveRecord::RecordNotFound)
  end

  describe 'POST create' do
    let(:moment) { create(:moment, :with_user) }

    context 'signed in as creator of the moment' do
      before { sign_in moment.user }

      it 'Creates Secret Share Identifier' do
        post secret_shares_path, params: { moment: moment.slug }

        expect(moment.reload.secret_share_identifier).not_to be_nil
        expect(response).to redirect_to moment_path(moment, anchor: 'secretShare')
      end
    end

    context 'signed in as another user' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'returns not found status' do
        post secret_shares_path, params: { moment: moment.slug }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'not signed in' do
      it 'does not create Secret Share Identifier' do
        post secret_shares_path, params: { moment: moment.slug }

        expect(moment.reload.secret_share_identifier).to be_nil
      end

      it 'redirects to sign in page' do
        post secret_shares_path, params: { moment: moment.slug }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET show' do
    context 'secret share is valid' do
      let(:moment) { create(:moment, :with_user, :with_secret_share) }

      it 'renders page' do
        get secret_share_path(id: moment.secret_share_identifier)

        expect(response).to be_successful
      end
    end

    context 'no secret share' do
      it 'returns not found status' do
        get secret_share_path(id: 'foobar')

        expect(response).to have_http_status(:not_found)
      end
    end

    # TODO: temporarily disable
    # context 'when secret share has expired' do
    #   let(:moment) { create(:moment, :with_user, :with_expired_secret_share) }
    #   it 'returns not found' do
    #     get secret_share_path(id: moment.secret_share_identifier)

    #     expect(response).to have_http_status(:not_found)
    #   end
    # end
  end

  describe 'DELETE' do
    let(:moment) { create(:moment, :with_user, :with_secret_share) }

    context 'signed in as creator of the moment' do
      before { sign_in moment.user }

      it 'deletes Secret Share Identifier' do
        delete secret_share_path(id: moment.id)

        expect(moment.reload.secret_share_identifier).to be_nil
      end
    end

    context 'signed in as another user' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'returns not found status' do
        delete secret_share_path(id: moment.id)

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'not signed in' do
      it 'redirects to sign in page' do
        delete secret_share_path(id: moment.id)

        expect(response).to redirect_to new_user_session_path
      end

      it 'does not delete Secret Share Identifier' do
        delete secret_share_path(id: moment.id)

        expect(moment.reload.secret_share_identifier).not_to be_nil
      end
    end
  end
end
