# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  comment_notify         :boolean
#  ally_notify            :boolean
#  group_notify           :boolean
#  meeting_notify         :boolean
#  locale                 :string
#  access_expires_at      :datetime
#  refresh_token          :string
#

describe User do
  let(:current_time) { Time.zone.now }

  describe '#from_omniauth' do
    OmniAuth.config.test_mode = true

    let(:auth) {
      OmniAuth.config.mock_auth[:provider] = OmniAuth::AuthHash.new({
          provider: "provider",
          uid: "12345678910",
          info: ({
            email: "janedoe@ifme.com",
            name: "Jane Doe"
          }),
          credentials: ({
            token: "abcde",
            expires_at:  current_time.to_i,
            refresh_token: "12345abcdefg",
          }),
        }
      )
    }

  after do
    OmniAuth.config.test_mode = false
  end

    context 'when user already exists' do
      let!(:user) {
        User.create(
          name: "Jane Doe",
          email: "janedoe@ifme.com",
          password: "asdfasdf"
        )
      }

      it 'updates user info from an oauth hash' do
        User.from_omniauth(auth)
        user.reload

        expect(user.provider).to eq("provider")
        expect(user.uid).to eq("12345678910")
        expect(user.email).to eq("janedoe@ifme.com")
        expect(user.name). to eq("Jane Doe")
        expect(user.token).to eq("abcde")
        expect(user.refresh_token).to eq("12345abcdefg")
        expect(user.access_expires_at).to eq(Time.at(current_time.to_i))
      end

      it "returns user" do
        expect(User.from_omniauth(auth)).to eq(user.reload)
      end
    end

    context "when user creates a new account" do
      it "creates a new user" do
        expect(User.where(email: "janedoe@ifme.com").first).to be_nil
        User.from_omniauth(auth)
        expect(User.where(email: "janedoe@ifme.com").first).to be_a_kind_of(User)
      end

      it "returns user" do
        expect(User.from_omniauth(auth)).to be_a_kind_of(User)
      end
    end
  end

  describe "#access_token" do
    let!(:user) { User.create(name: "some name",
                              email: "some@user.com", 
                              password: "asdfasdf", 
                              token: "some token" )}

    context "no expiration saved" do
      it "updates the access token" do
        User.stub(:update_access_token) {
          "some new token"
        }
        user.access_expires_at = nil

        expect_any_instance_of(User).to receive(:update_access_token)
        user.google_access_token
      end
    end

    context "an expired token" do
      before do
        user.access_expires_at = current_time - 600
      end

      it "updates the access token" do
        User.stub(:update_access_token) {
          "some new token"
        }
        expect_any_instance_of(User).to receive(:update_access_token)
        user.google_access_token
      end
    end

    context "a valid token" do
      before do
        user.access_expires_at = current_time + 600
      end

      it "returns the current token" do
        expect_any_instance_of(User).not_to receive(:update_access_token)
        expect(user.google_access_token).to eq("some token")
      end
    end
  end

  describe "#available_groups" do
    it "returns the groups that allys belong to and the user doesn't" do
      user = create :user1
      user_groups = create_list :group_with_member, 2, userid: user.id
      ally = create :user2
      create :allyships_accepted, user_id: user.id, ally_id: ally.id
      group_only_ally_belongs_to = create(:group_with_member, userid: ally.id)
      group_both_belong_to = user_groups.first
      create :group_member, groupid: group_both_belong_to.id, userid: ally.id

      result = user.available_groups("groups.created_at DESC")

      expect(result).to eq [group_only_ally_belongs_to]
    end
  end
end