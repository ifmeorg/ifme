# frozen_string_literal: true
# == Schema Information
#
# Table name: meeting_members
#
#  id                  :bigint           not null, primary key
#  meeting_id          :integer
#  user_id             :integer
#  leader              :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  google_cal_event_id :string
#

describe MeetingMember do
  context 'with validations' do
    it { is_expected.to validate_presence_of :meeting_id }
    it { is_expected.to validate_presence_of :user_id }
  end

  context 'with relations' do
    it { is_expected.to belong_to :meeting }
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to(:group_member).optional }
  end

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
