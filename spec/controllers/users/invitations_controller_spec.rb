RSpec.describe ::Users::InvitationsController, type: :controller do
  let(:user) { create(:user, name: 'Jane') }
  let(:invitee1) { 'invitedfriend@gmail.com' }
  let(:invitee2) { 'otherfriend@gmail.com' }
  let(:invalid_email) { 'invalidemail.com' }

  describe '#create' do
    before(:each) { @request.env["devise.mapping"] = Devise.mappings[:user] }

    context 'when a user is not signed in' do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end

    context 'when a user is signed in' do
      include_context :logged_in_user

      context 'when valid params are given' do
        let(:invite_one_friend) { post :create, params: { user: { email: "#{invitee1}" } } }
        after(:each) { Devise.mailer.deliveries.clear }

        it 'creates a new user if the user does not exist' do
          users_count = User.count
          invite_one_friend
          expect(User.count).to eq(users_count + 1)
        end

        it 'sends an invitation email to the invitee' do
          invite_one_friend
          expect(Devise.mailer.deliveries.count).to eq(1)
        end

        it 'redirects to invitations#new' do
          invite_one_friend
          expect(response).to redirect_to new_user_invitation_path
        end

        context 'when the user has invited multiple friends' do
          let(:friends_array) { [invitee1, invitee2] }
          let(:invite_two_friends) do
            post :create, params: { user: { email: "#{invitee1}, #{invitee2}" } }
          end

          it 'creates a new user for each supplied email address' do
            invite_two_friends
            newest_users = User.order(invitation_sent_at: :desc).last(2)
            emails = []
            newest_users.each { |u| emails << u.email }
            expect(emails.sort).to eq(friends_array.sort)
          end

          it 'sends an invitation email to each valid address' do
            invite_two_friends
            emails = []
            Devise.mailer.deliveries.each { |d| emails << d.to[0] }
            expect(Devise.mailer.deliveries.count).to eq(2)
            expect(emails.sort).to eq(friends_array.sort)
          end

          it 'creates a unique token for each email' do
            invite_two_friends
            friend1 = User.find_by(email: invitee1)
            friend2 = User.find_by(email: invitee2)
            expect(friend1.invitation_token).not_to eq(friend2.invitation_token)
          end
        end
      end

      context 'when invalid params are given' do
        let(:invalid_invite) { post :create, params: { user: { email: "#{invalid_email}" } } }

        it 're-renders the invitation form' do
          invalid_invite
          expect(response).to redirect_to new_user_invitation_path
        end

        it 'does not create a new user for an invalid email' do
          user_count = User.count
          invalid_invite
          expect(User.count).to eq(user_count)
        end
      end
    end
  end
end
