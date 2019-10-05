# frozen_string_literal: true
# == Schema Information
#
# Table name: group_members
#
#  id         :bigint(8)        not null, primary key
#  group_id   :integer
#  user_id    :integer
#  leader     :boolean
#  created_at :datetime
#  updated_at :datetime
#

describe GroupMember do
  context 'with validations' do
    it { is_expected.to validate_presence_of :group_id }
    it { is_expected.to validate_presence_of :user_id }
  end

  context 'with relations' do
    it { is_expected.to belong_to :group }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:meetings).through(:group) }
    it { is_expected.to have_many(:meeting_memberships).through(:meetings) }
  end

  it 'has a valid factory' do
    group_member = build :group_member
    expect(group_member).to be_valid
  end
  context 'when group_id is nil' do
    it 'is not valid' do
      group_member = build :group_member, group_id: nil
      expect(group_member).to have(1).error_on(:group_id)
    end
  end

  describe '#meeting_members' do
    context 'when it has associated meeting_memberships' do
      it 'returns the meeting_memberships' do
        group_member = create :group_member
        meeting = create :meeting, group_id: group_member.group_id
        meeting_member = create :meeting_member, meeting_id: meeting.id,
                                                 user_id: group_member.user_id

        expect(group_member.meeting_memberships).to eq [meeting_member]
      end
    end
  end

  describe '#destroy' do
    context 'when it has associated meeting_members' do
      it 'destroys the meeting_memberships' do
        group_member = create :group_member
        meeting = create :meeting, group_id: group_member.group_id
        meeting_member = create :meeting_member, meeting_id: meeting.id,
                                                 user_id: group_member.user_id

        expect { group_member.destroy }.to change(MeetingMember, :count).by(-1)
      end
    end
  end
end
