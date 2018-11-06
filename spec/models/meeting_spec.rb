# frozen_string_literal: true
# == Schema Information
#
# Table name: meetings
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  location    :text
#  time        :string
#  maxmembers  :integer
#  group_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#  date        :string
#  slug        :string
#

describe Meeting do
  it 'has a valid factory' do
    result = build :meeting

    expect(result).to be_valid
  end
  context 'when meeting does not have a group id' do
    it 'is not valid' do
      new_meeting = build(:meeting, group_id: nil)
      expect(new_meeting).to have(1).error_on(:group_id)
    end
  end

  describe '#leaders' do
    context 'when meeting has leaders' do
      it 'returns the leaders' do
        leader = create :user1
        non_leader = create :user2
        meeting = create :meeting
        create :meeting_member, user_id: leader.id, leader: true,
                                meeting_id: meeting.id
        create :meeting_member, user_id: non_leader.id, leader: false,
                                meeting_id: meeting.id

        result = meeting.leaders

        expect(result).to eq [leader]
      end
    end

    context 'when meeting has no leaders' do
      it 'returns an empty array' do
        non_leader = create :user1
        meeting = create :meeting
        create :meeting_member, user_id: non_leader.id, leader: false,
                                meeting_id: meeting.id

        result = meeting.leaders

        expect(result).to eq []
      end
    end
  end

  describe '#led_by?' do
    context 'when user is not a leader of the meeting' do
      it 'returns false' do
        user = create :user1
        meeting = create :meeting
        create :meeting_member, user_id: user.id, leader: false,
                                meeting_id: meeting.id

        result = meeting.led_by?(user)

        expect(result).to be false
      end
    end

    context 'when user is a leader of the meeting' do
      it 'returns true' do
        user = create :user1
        meeting = create :meeting
        create :meeting_member, user_id: user.id, leader: true,
                                meeting_id: meeting.id

        result = meeting.led_by?(user)

        expect(result).to be true
      end
    end
  end

  describe '#member?' do
    context 'when user is not a member of the meeting' do
      it 'returns false' do
        user = create :user1
        member = create :user2
        meeting = create :meeting
        create :meeting_member, user_id: member.id, leader: false,
                                meeting_id: meeting.id

        result = meeting.member?(user)

        expect(result).to be false
      end
    end

    context 'when user is a member of the meeting' do
      it 'returns true' do
        user = create :user1
        meeting = create :meeting
        create :meeting_member, user_id: user.id, leader: false,
                                meeting_id: meeting.id

        result = meeting.member?(user)

        expect(result).to be true
      end
    end
  end
end
