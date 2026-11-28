# frozen_string_literal: true

describe 'PausedAccounts', type: :request do
  let(:user) { create(:user1) }
  let(:other) { create(:user2) }

  # The factory only accepts one side; real allies have both accepted.
  def make_allies
    create(:allyships_accepted, user: other, ally: user)
    Allyship.where(user: user, ally: other)
            .update_all(status: Allyship.statuses[:accepted])
  end

  describe 'pausing' do
    before { sign_in user }

    it 'pauses the account and signs out' do
      post paused_account_path

      expect(user.reload).to be_paused
      expect(response).to redirect_to(new_user_session_path)

      get moments_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'is offered on the account settings page' do
      get edit_user_registration_path

      expect(response.body).to include('Pause my account')
    end
  end

  describe 'a signed in paused account' do
    before do
      user.pause!
      sign_in user
    end

    it 'is sent to the resume page from other pages' do
      [root_path, moments_path, allies_path, edit_user_registration_path]
        .each do |path|
          get path
          expect(response).to redirect_to(paused_account_path)
        end
    end

    it 'cannot create content' do
      expect do
        post moments_path,
             params: { moment: { name: 'a', why: 'b', comment: '0' } }
      end.not_to change(Moment, :count)
    end

    it 'sees the resume page' do
      get paused_account_path

      expect(response).to be_successful
      expect(response.body).to include('Resume my account')
    end

    it 'can resume' do
      delete paused_account_path

      expect(user.reload).not_to be_paused
      expect(response).to redirect_to(root_path)
    end

    it 'can permanently delete the account' do
      delete user_registration_path

      expect(User.where(id: user.id)).to be_empty
    end

    it 'can sign out' do
      delete destroy_user_session_path

      get moments_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'what other people can reach' do
    let(:moment) do
      create(:moment, :with_published_at, user: user, viewers: [other.id])
    end

    before do
      make_allies
      moment
      user.pause!
      sign_in other
    end

    it 'is all reachable again after resuming' do
      user.resume!

      get profile_index_path(uid: user.uid)
      expect(response).to be_successful

      get moment_path(moment)
      expect(response).to be_successful

      get search_index_path, params: { search: { email: user.email } }
      expect(assigns(:matching_users)).to contain_exactly(user)
    end

    it 'hides the profile' do
      get profile_index_path(uid: user.uid)

      expect(response).to redirect_to(allies_path)
    end

    it 'keeps the profile visible to admins for moderation' do
      sign_in create(:user, admin: true)

      get profile_index_path(uid: user.uid)

      expect(response).to be_successful
    end

    it 'hides moments, even from a listed viewer' do
      get moment_path(moment)

      expect(response).to redirect_to(moments_path)
    end

    it 'hides the account from search' do
      get search_index_path, params: { search: { email: user.email } }

      expect(assigns(:matching_users)).to be_empty
    end

    it 'does not allow new comments on their moments' do
      expect do
        post comments_path, params: { comment: {
          commentable_type: 'Moment', commentable_id: moment.id,
          comment: 'Hello', visibility: 'all'
        } }
      end.not_to change(Comment, :count)
      expect(response).to have_http_status(:bad_request)
    end

    it 'turns off secret share links' do
      moment.update!(secret_share_identifier: SecureRandom.uuid,
                     secret_share_expires_at: 1.day.from_now)

      get secret_share_path(moment.secret_share_identifier)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'ally requests' do
    it 'cannot be sent to a paused account' do
      user.pause!
      sign_in other

      expect { post add_allies_path(ally_id: user.id) }
        .not_to change(Allyship, :count)
    end
  end

  describe 'earlier comments' do
    it 'stay, without the identity of the paused author' do
      make_allies
      moment = create(:moment, :with_published_at,
                      user: other, viewers: [user.id], comment: true)
      Comment.create!(commentable_type: 'Moment', commentable_id: moment.id,
                      comment_by: user.id, comment: 'Thinking of you',
                      visibility: 'all')
      user.pause!
      sign_in other

      get moment_path(moment)

      shown = assigns(:comments).first
      expect(shown[:comment]).to include('Thinking of you')
      expect(shown[:commentByName]).to eq('[removed]')
      expect(shown[:commentByUid]).to be_nil
      expect(shown[:commentByAvatar]).to be_nil
    end
  end
end
