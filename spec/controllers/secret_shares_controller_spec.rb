# frozen_string_literal: true

describe SecretSharesController, type: :controller do
  def raise_record_not_found
    raise_error(ActiveRecord::RecordNotFound)
  end

  describe 'POST create' do
    def do_post_create
      post :create, params: { moment: moment }
    end
    let(:moment) { create(:moment, :with_user) }
    context 'signed in as creator of the moment' do
      before do
        sign_in moment.user
        do_post_create
      end

      it 'Creates Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).not_to be_nil
        expect(response).to redirect_to moment_path(moment, anchor: 'secretShare')
      end
    end

    context 'signed in as another user' do
      before do
        new_user = create(:user)
        sign_in new_user
      end

      specify { expect { do_post_create }.to raise_record_not_found }
    end

    context 'not signed in' do
      before do
        do_post_create
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
    def do_get_show(secret_share_identifier = moment.secret_share_identifier)
      get :show, params: { id: secret_share_identifier }
    end
    context 'secret share is valid' do
      before { do_get_show }
      let(:moment) { create(:moment, :with_user, :with_secret_share) }
      specify { expect(response).to render_template(:show) }
    end

    context 'no secret share' do
      specify do
        expect { do_get_show('foobar') }
          .to raise_record_not_found
      end
    end

    # TODO: temporarily disable
    # context 'when secret share has expired' do
    #   let(:moment) { create(:moment, :with_user, :with_expired_secret_share) }
    #   specify { expect { do_get_show }.to raise_record_not_found }
    # end
  end

  describe 'DELETE' do
    def do_delete_destroy
      delete :destroy, params: { id: moment.id }
    end
    let(:moment) { create(:moment, :with_user, :with_secret_share) }
    context 'signed in as creator of the moment' do
      before do
        sign_in moment.user
        do_delete_destroy
      end

      it 'deletes Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).to be_nil
      end
    end

    context 'signed in as another user' do
      before do
        new_user = create(:user)
        sign_in new_user
      end

      specify { expect { do_delete_destroy }.to raise_record_not_found }
    end

    context 'not signed in' do
      before do
        do_delete_destroy
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end

      it 'does not delete Secret Share Identifier' do
        expect(moment.reload.secret_share_identifier).not_to be_nil
      end
    end
  end
end
