# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  location               :string
#  timezone               :string
#  about                  :text
#  avatar                 :string
#  conditions             :text
#  token                  :string
#  uid                    :string
#  provider               :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default(0)
#  comment_notify         :boolean
#  ally_notify            :boolean
#  group_notify           :boolean
#  meeting_notify         :boolean
#  locale                 :string
#  access_expires_at      :datetime
#  refresh_token          :string
#  banned                 :boolean          default(FALSE)
#  admin                  :boolean          default(FALSE)
#

describe User do
  let(:current_time) { Time.zone.now }

  describe '#active_for_authentication?' do
    context 'has unbanned user' do
      let(:user) { create(:user) }

      it 'returns true' do
        expect(user.active_for_authentication?).to eq(true)
      end
    end

    context 'has banned user' do
      let(:user) { create(:user, banned: true) }

      it 'returns false' do
        expect(user.active_for_authentication?).to eq(false)
      end
    end
  end

  describe '#ally?' do
    let(:banned) { false }
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2, banned: banned) }

    context 'users are allies' do
      before do
        create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns true' do
          expect(user1.ally?(user2)).to eq(true)
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns true' do
          expect(user1.ally?(user2)).to eq(false)
        end
      end
    end

    context 'users are not allies' do
      it 'returns false' do
        expect(user1.ally?(user2)).to eq(false)
      end
    end
  end

  describe '#allies_by_status' do
    let(:banned) { false }
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2, banned: banned) }

    context 'has accepted status' do
      before do
        create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns array with ally' do
          expect(user1.allies_by_status(:accepted)).to eq([user2])
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns empty array' do
          expect(user1.allies_by_status(:accepted)).to eq([])
        end
      end
    end

    context 'has pending_from_user status' do
      before do
        create(:allyships_pending_from_user_id1, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns array with ally' do
          expect(user1.allies_by_status(:pending_from_user)).to eq([user2])
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns empty array' do
          expect(user1.allies_by_status(:pending_from_user)).to eq([])
        end
      end
    end

    context 'has pending_from_ally status' do
      before do
        create(:allyships_pending_from_user_id2, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns array with ally' do
          expect(user1.allies_by_status(:pending_from_ally)).to eq([user2])
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns empty array' do
          expect(user1.allies_by_status(:pending_from_ally)).to eq([])
        end
      end
    end
  end

  describe '#find_for_google_oauth2' do
    let(:access_token) do
      double(
        info: double(email: 'some@user.com', name: 'some name'),
        provider: 'asdf',
        credentials: double(token: 'some token',
                            expires_at: current_time.to_i,
                            refresh_token: 'some refresh token'),
        uid: 'some uid'
      )
    end

    context 'an existing user' do
      let!(:user) { User.create(name: 'some name', email: 'some@user.com', password: 'asdfaS1!df') }

      it 'updates token information' do
        User.find_for_google_oauth2(access_token)
        user.reload
        expect(user.provider).to eq('asdf')
        expect(user.token).to eq('some token')
        expect(user.refresh_token).to eq('some refresh token')
        expect(user.uid).to eq('some uid')
        expect(user.access_expires_at).to eq(Time.at(current_time.to_i))
      end

      it 'returns a user' do
        expect(User.find_for_google_oauth2(access_token)).to eq(user.reload)
      end
    end

    context 'a new user' do
      it 'creates a new user' do
        expect(User.where(email: 'some@user.com').first).to be_nil
        User.find_for_google_oauth2(access_token)
        expect(User.where(email: 'some@user.com').first).to be_a_kind_of(User)
      end

      it 'returns a user' do
        expect(User.find_for_google_oauth2(access_token)).to be_a_kind_of(User)
      end
    end
  end

  describe '#access_token' do
    let!(:user) do
      User.create(name: 'some name',
                  email: 'some@user.com',
                  password: 'asdfasdF!1',
                  token: 'some token')
    end

    context 'no expiration saved' do
      it 'updates the access token' do
        User.stub(:update_access_token) do
          'some new token'
        end
        user.access_expires_at = nil

        expect_any_instance_of(User).to receive(:update_access_token)
        user.google_access_token
      end
    end

    context 'an expired token' do
      before do
        user.access_expires_at = current_time - 600
      end

      it 'updates the access token' do
        User.stub(:update_access_token) do
          'some new token'
        end
        expect_any_instance_of(User).to receive(:update_access_token)
        user.google_access_token
      end
    end

    context 'a valid token' do
      before do
        user.access_expires_at = current_time + 600
      end

      it 'returns the current token' do
        expect_any_instance_of(User).not_to receive(:update_access_token)
        expect(user.google_access_token).to eq('some token')
      end
    end
  end

  describe '#validations' do
    context 'password' do
      let(:user) { build(:user, password: nil) }

      context 'when password is blank' do
        it 'throws password error only from devise' do
          expect(user.valid?).to be false

          expect(user).to have(1).error_on(:password)
          expect(user.errors[:password]).not_to include(I18n.t('devise.registrations.password_complexity_error'))
        end
      end

      context 'when oauth is enabled' do
        it 'doesnt throw any errors even if the password strength is less' do
          user.password = 'warsdasdf'
          user.token = 'access token'
          expect(user.valid?).to be true
        end
      end

      context 'when password is valid' do
        it 'doesnt throw any errors' do
          user.password = 'waspAr$0'
          expect(user.valid?).to be true
        end
      end

      context 'when password is invalid' do
        it 'returns respective error message' do
          ['waspar$0', 'waspaRs0', 'waspar$o', 'WASPAR$0', 'Was$0'].each do |password|
            user.password = password
            expect(user.valid?).to be false

            expect(user).to have(1).error_on(:password)
          end
        end
      end
    end
  end

  describe '#available_groups' do
    it "returns the groups that allys belong to and the user doesn't" do
      user = create :user1
      user_groups = create_list :group_with_member, 2, user_id: user.id
      ally = create :user2
      create :allyships_accepted, user_id: user.id, ally_id: ally.id
      group_only_ally_belongs_to = create(:group_with_member, user_id: ally.id)
      group_both_belong_to = user_groups.first
      create :group_member, group_id: group_both_belong_to.id, user_id: ally.id

      result = user.available_groups('groups.created_at DESC')

      expect(result).to eq [group_only_ally_belongs_to]
    end
  end

  describe '#update_access_token' do
    let!(:user) do
      User.create(name: 'some name',
                  email: 'some@user.com',
                  password: 'asdfasdf',
                  token: 'some token')
    end

    request = {
      'refresh_token'   =>  nil,
      'client_id'       =>  ENV['GOOGLE_CLIENT_ID'],
      'client_secret'   =>  ENV['GOOGLE_CLIENT_SECRET'],
      'grant_type'      =>  'refresh_token'
    }

    context 'when request is successful' do
      before do
        response = {
          'access_token': 'MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3',
          'token_type': 'bearer',
          'expires_in': 3600,
          'refresh_token': 'IwOGYzYTlmM2YxOTQ5MGE3YmNmMDFkNTVk',
          'scope': 'create'
        }.to_json

        Net::HTTP.stub(:post_form).with(URI.parse(User::OAUTH_TOKEN_URL), request) { double(body: response) }
      end

      it 'returns a new access token' do
        expect(user.update_access_token).to eq('MTQ0NjJkZmQ5OTM2NDE1ZTZjNGZmZjI3')
      end
    end

    context 'when request is unsuccessful' do
      before do
        response = {
          'error': 'invalid request',
          'error_description': 'Could not determine client ID from request.'
        }.to_json

        Net::HTTP.stub(:post_form).with(URI.parse(User::OAUTH_TOKEN_URL), request) { double(body: response) }
      end

      it 'returns a new access token' do
        expect { user.update_access_token }.to raise_error(NoMethodError)
      end
    end
  end
end
