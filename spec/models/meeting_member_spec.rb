# frozen_string_literal: true
# == Schema Information
#
# Table name: meeting_members
#
#  id         :bigint(8)        not null, primary key
#  meeting_id :integer
#  user_id    :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

describe MeetingMember do
  it 'has a valid factory' do
    meeting_member = build :meeting_member
    expect(meeting_member).to be_valid
  end

  context 'when meeting_id is nil' do
    it 'is invalid' do
      meeting_member = build :meeting_member, meeting_id: nil
      expect(meeting_member).to have(1).error_on(:meeting_id)
    end
  end
end
