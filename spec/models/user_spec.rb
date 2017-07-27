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
#

describe User do
  describe ".find_for_google_oauth2" do
    let(:access_token) {
      double({
                info: double({ email: "some@user.com", name: "some name" }),
                provider: "asdf",
                credentials: double({ token: "some token" }),
                uid: "some uid"
      })
    }

    context "an existing user" do
      let!(:user) { User.create(name: "some name", email: "some@user.com", password: "asdfasdf") }

      it "updates token information" do
        User.find_for_google_oauth2(access_token)
        user.reload
        expect(user.provider).to eq("asdf")
        expect(user.token).to eq("some token")
        expect(user.uid).to eq("some uid")
      end

      it "returns a user" do
        expect(User.find_for_google_oauth2(access_token)).to eq(user.reload)
      end
    end

    context "a new user" do
      it "creates a new user" do
        expect(User.where(email: "some@user.com").first).to be_nil
        User.find_for_google_oauth2(access_token)
        expect(User.where(email: "some@user.com").first).to be_a_kind_of(User)
      end

      it "returns a user" do
        expect(User.find_for_google_oauth2(access_token)).to be_a_kind_of(User)
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
