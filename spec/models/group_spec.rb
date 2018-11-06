# frozen_string_literal: true
# == Schema Information
#
# Table name: groups
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  slug        :string
#

describe Group do
  it 'creates a group' do
    new_group = create(:group, description: 'Test Description')
    expect(Group.count).to eq(1)
  end

  it 'does not create a group' do
    new_group = build(:bad_group)
    expect(new_group).to have(1).error_on(:description)
  end

  describe '#led_by?' do
    context 'when user is not a leader of the group' do
      it 'returns false' do
        user = create :user1
        group = create :group_with_member, user_id: user.id, leader: false

        result = group.led_by?(user)

        expect(result).to be false
      end
    end

    context 'when user is a leader of the group' do
      it 'returns true' do
        user = create :user1
        group = create :group_with_member, user_id: user.id, leader: true

        result = group.led_by?(user)

        expect(result).to be true
      end
    end
  end

  describe '#member?' do
    context 'when user is not a member of the group' do
      it 'returns false' do
        member_user = create :user
        non_member_user = create :user1
        group = create :group_with_member, user_id: member_user.id

        result = group.member?(non_member_user)

        expect(result).to be false
      end
    end

    context 'when user is a member of the group' do
      it 'returns true' do
        user = create :user1
        group = create :group_with_member, user_id: user.id

        result = group.member?(user)

        expect(result).to be true
      end
    end
  end

  describe '#leaders' do
    context 'when group has leaders' do
      it 'returns the leaders' do
        leader = create :user1
        non_leader = create :user2
        group = create :group_with_member, user_id: leader.id, leader: true
        create :group_member, user_id: non_leader.id, group_id: group.id,
                              leader: false

        result = group.leaders

        expect(result).to eq [leader]
      end
    end

    context 'when group has no leaders' do
      it 'returns an empty array' do
        non_leader = create :user1
        group = create :group_with_member, user_id: non_leader.id, leader: false

        result = group.leaders

        expect(result).to eq []
      end
    end
  end

  describe '#members' do
    it 'returns group members in alphabetical order' do
      group = create :group
      names = %w[bryan charlie alex]
      names.each do |name|
        user = create :user1, name: name
        create :group_member, user_id: user.id, group_id: group.id
      end

      result = group.members

      expect(result.map(&:name)).to eq %w[alex bryan charlie]
    end
  end

  describe '#destroy' do
    before(:each) do
      @group = create :group
      @meeting = create :meeting, group_id: @group.id
    end

    it 'destroys associated meetings' do
      expect { @group.destroy }.to change(Meeting, :count).by(-1)
    end

    it 'destroys associated meeting_members' do
      create :meeting_member, meeting: @meeting

      expect { @group.destroy }.to change(MeetingMember, :count).by(-1)
    end

    it 'destroys associated notifications' do
      group = create :group
      create_notification_for(group)

      expect { group.destroy }.to change(Notification, :count).by(-1)
    end
  end

  describe '#notifications' do
    it 'returns the notifications with a uniqueid contiaining "new_group"' do
      group = build_stubbed :group
      notification = create_notification_for(group)

      result = group.notifications

      expect(result).to eq [notification]
    end
  end

  def create_notification_for(group)
    data = { group_id: group.id }.to_json
    create :notification, uniqueid: 'new_group_1', data: data
  end
end
