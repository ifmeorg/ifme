# frozen_string_literal: true

RSpec.describe 'Invitation', type: :request do
  let(:user) { create(:user, name: 'Jane') }
  let(:invitee1) { 'invited_friend@gmail.com' }
  let(:invitee2) { 'other_friend@gmail.com' }

  describe '#create' do
    let(:invalid_email) { 'invalid_email.com' }

    context 'when a user is not signed in' do
      before { post user_invitation_path }
      it_behaves_like :with_no_logged_in_user
    end

    context 'when a user is signed in' do
      before { sign_in user }

      context 'when valid params are given' do
        let(:invite_one_friend) { post user_invitation_path, params: { user: { email: invitee1 } } }

        it 'creates a new user if the user does not exist' do
          expect { invite_one_friend }.to change { User.count }.by(1)
        end

        it 'sends an invitation email to the invitee' do
          expect { invite_one_friend }.to change { Devise.mailer.deliveries.count }.by(1)
        end

        it 'redirects to invitations#new' do
          # Act
          invite_one_friend

          # Assert
          expect(response).to redirect_to new_user_invitation_path
        end

        context 'when the user has invited multiple friends' do
          let(:friends_array) { [invitee1, invitee2] }
          before(:each) do
            post user_invitation_path, params: { user: { email: "#{invitee1}, #{invitee2}" } }
          end

          it 'creates a new user for each supplied email address' do
            # Arrange
            emails = User.order(invitation_sent_at: :desc).last(friends_array.count).pluck(:email)

            # Assert
            expect(emails).to match_array(friends_array)
          end

          it 'sends an invitation email to each valid address' do
            # Arrange
            emails = []

            # Act
            Devise.mailer.deliveries.each { |d| emails << d.to[0] }

            # Assert
            expect(Devise.mailer.deliveries.count).to eq(friends_array.count)
            expect(emails).to match_array(friends_array)
          end

          it 'creates a unique token for each email' do
            # Arrange
            friend1 = User.find_by(email: invitee1)
            friend2 = User.find_by(email: invitee2)

            # Assert
            expect(friend1.invitation_token).not_to eq(friend2.invitation_token)
          end
        end
      end

      context 'when invalid params are given' do
        let(:invalid_invite) {
          post user_invitation_path, params: { user: { email: invalid_email } }
        }

        it 're-renders the invitation form' do
          # Act
          invalid_invite

          # Assert
          expect(response).to redirect_to new_user_invitation_path
        end

        it 'does not create a new user for an invalid email' do
          expect { invalid_invite }.not_to change { User.count }
        end
      end

      context 'when both valid and invalid params are given' do
        let(:valid_and_invalid_invite) {
          post user_invitation_path, params: { user: { email: "#{invitee1}, #{invalid_email}" } }
        }

        it 'only creates a new User for the valid email' do
          # Assume
          emails = User.pluck(:email)
          expect(emails).not_to include(invitee1)
          expect(emails).not_to include(invalid_email)

          # Act
          valid_and_invalid_invite

          # Assert
          emails = User.pluck(:email)
          expect(emails).to include(invitee1)
          expect(emails).not_to include(invalid_email)
        end

        it 'only sends an invitation email to the valid email address' do
          # Arrange
          emails = []

          # Act
          expect { valid_and_invalid_invite }.to change { Devise.mailer.deliveries.count }.by(1)

          # Assert
          Devise.mailer.deliveries.each { |d| emails << d.to[0] }
          expect(emails).to include(invitee1)
          expect(emails).not_to include(invalid_email)
        end
      end
    end
  end

  describe '#update' do
    let(:password) { 'passworD@99' }
    let(:name) { 'New Person' }
    let(:invited_user) { User.invite!({ email: invitee1 }, user) }

    context 'when valid params are given' do
      it 'creates allyship with pending_from_ally status when a user accepts an invitation' do
        # Arrange
        update_params = { name: name, password: password, password_confirmation: password, invitation_token: invited_user.raw_invitation_token }
        allow_any_instance_of(::Users::InvitationsController).to receive(:update_resource_params).and_return(update_params)

        # Assume
        expect(user.allies_by_status(:pending_from_ally)).to be_empty

        # Act
        put user_invitation_path, params: update_params

        # Assert
        expect(user.allies_by_status(:pending_from_ally)).not_to be_empty
        expect(user.allies_by_status(:pending_from_ally).first).to eq(invited_user)
        expect(response).to have_http_status(302)
      end
    end

    context 'when invalid params are given' do
      it 'does not create an allyship' do
        # Arrange
        allow_any_instance_of(::Users::InvitationsController).to receive(:update_resource_params).and_return({})

        # Assume
        expect(user.allies_by_status(:pending_from_ally)).to be_empty

        # Act
        put user_invitation_path, params: {}

        # Assert
        expect(user.allies_by_status(:pending_from_ally)).to be_empty
        expect(response).to have_http_status(200)
      end
    end

    context 'when both valid and invalid params are given' do
      it 'does not create an allyship' do
        # Arrange
        update_params = { password: password, password_confirmation: password, invitation_token: invited_user.raw_invitation_token }
        allow_any_instance_of(::Users::InvitationsController).to receive(:update_resource_params).and_return(update_params)

        # Assume
        expect(user.allies_by_status(:pending_from_ally)).to be_empty

        # Act
        put user_invitation_path, params: update_params

        # Assert
        expect(user.allies_by_status(:pending_from_ally)).to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end
end
