# frozen_string_literal: true

# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
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

  describe '.leaders' do
    context 'when group has leaders' do
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

    context 'when group has no leaders' do
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
end
