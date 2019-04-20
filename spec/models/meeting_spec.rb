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

  describe '#meeting_member' do
    let!(:user) { create :user1 }
    let!(:member) { create :user2 }
    let!(:meeting) { create :meeting }
    let!(:meeting_member) do
      create :meeting_member, user_id: member.id, leader: false,
                              meeting_id: meeting.id
    end
    context 'when user is not a member of the meeting' do
      it 'returns nil' do
        expect(meeting.meeting_member(user)).to be nil
      end
    end

    context 'when user is a member of the meeting' do
      it 'returns true' do
        expect(meeting.meeting_member(member)).to eq meeting_member
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

  describe '#date_time' do
    context 'when date is not available' do
      it 'returns nil' do
        meeting = build(:meeting, time: Time.now.in_time_zone.strftime('%H:%M'), date: nil)

        expect(meeting.date_time).to be nil
      end
    end

    context 'when time is not available' do
      it 'returns nil' do
        meeting = build(:meeting, date: Date.today.to_s, time: nil)

        expect(meeting.date_time).to be nil
      end
    end

    context 'when both date and time are not available' do
      it 'returns nil' do
        meeting = build(:meeting, date: nil, time: nil)

        expect(meeting.date_time).to be nil
      end
    end

    context 'when both time and date are available' do
      it 'returns date_time' do
        date = Date.new(2017, 0o3, 19).to_s
        time = '03:19'
        date_time = DateTime.new(2017, 0o3, 19, 0o3, 19).in_time_zone
        meeting = build(:meeting, date: date, time: time)

        expect(meeting.date_time).to eq date_time
      end
    end
  end
end
