# frozen_string_literal: true

RSpec.describe ::Users::InvitationsController, type: :controller do
  let(:user) { create(:user, name: 'Jane') }
  let(:invitee1) { 'invited_friend@gmail.com' }
  let(:invitee2) { 'other_friend@gmail.com' }
  let(:invalid_email) { 'invalid_email.com' }
  let(:invite_one_friend) { post :create, params: { user: { email: invitee1 } } }

  before(:each) { @request.env['devise.mapping'] = Devise.mappings[:user] }
  after(:each) { Devise.mailer.deliveries.clear }

  describe '#create' do
    context 'when a user is not signed in' do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end

    context 'when a user is signed in' do
      include_context :logged_in_user

      context 'when valid params are given' do
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
          before(:each) do
            post :create, params: { user: { email: "#{invitee1}, #{invitee2}" } }
          end

          it 'creates a new user for each supplied email address' do
            newest_users = User.order(invitation_sent_at: :desc).last(2)
            emails = []
            newest_users.each { |u| emails << u.email }
            expect(emails.sort).to eq(friends_array.sort)
          end

          it 'sends an invitation email to each valid address' do
            emails = []
            Devise.mailer.deliveries.each { |d| emails << d.to[0] }
            expect(Devise.mailer.deliveries.count).to eq(2)
            expect(emails.sort).to eq(friends_array.sort)
          end

          it 'creates a unique token for each email' do
            friend1 = User.find_by(email: invitee1)
            friend2 = User.find_by(email: invitee2)
            expect(friend1.invitation_token).not_to eq(friend2.invitation_token)
          end
        end
      end

      context 'when invalid params are given' do
        let(:invalid_invite) { post :create, params: { user: { email: invalid_email } } }

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

      context 'when both valid and invalid params are given' do
        before(:each) do
          post :create, params: { user: { email: "#{invitee1}, #{invalid_email}" } }
        end

        it 'only creates a new User for the valid email' do
          newest_users = User.order(invitation_sent_at: :desc).last(2)
          emails = []
          newest_users.each { |u| emails << u.email }
          expect(emails.sort).to include(invitee1)
          expect(emails.sort).not_to include(invalid_email)
        end

        it 'only sends an invitation email to the valid email address' do
          emails = []
          Devise.mailer.deliveries.each { |d| emails << d.to[0] }
          expect(Devise.mailer.deliveries.count).to eq(1)
          expect(emails.sort).to include(invitee1)
          expect(emails.sort).not_to include(invalid_email)
        end
      end
    end
  end

  describe '#update' do
    include_context :logged_in_user
    let(:password) { 'passworD@99' }

    before(:each) do
      invite_one_friend
    end

    context 'when valid params are given' do
      let(:name) { 'New Person' }

      it 'creates allyship with pending_from_ally status when a user accepts an invitation' do
        User.stub(:find_by_invitation_token) do
          User.last
        end
        update_params = { name: name, password: password, password_confirmation: password, invitation_token: User.last.invitation_token }
        allow_any_instance_of(::Users::InvitationsController).to receive(:update_resource_params).and_return(update_params)
        put :update, params: update_params
        expect(user.allies_by_status(:pending_from_ally).first).to eq(User.last)
        expect(response).to have_http_status(302)
      end
    end

    context 'when invalid params are given' do
      it 'does not create an allyship' do
        User.stub(:find_by_invitation_token) do
          User.last
        end
        allow_any_instance_of(::Users::InvitationsController).to receive(:update_resource_params).and_return({})
        put :update, params: {}
        expect(user.allies_by_status(:pending_from_ally).length).to eq(0)
        expect(response).to have_http_status(200)
      end
    end

    context 'when both valid and invalid params are given' do
      it 'does not create an allyship' do
        User.stub(:find_by_invitation_token) do
          User.last
        end
        update_params = { password: password, password_confirmation: password, invitation_token: User.last.invitation_token }
        allow_any_instance_of(::Users::InvitationsController).to receive(:update_resource_params).and_return(update_params)
        put :update, params: update_params
        expect(user.allies_by_status(:pending_from_ally).length).to eq(0)
        expect(response).to have_http_status(200)
      end
    end
  end
end
