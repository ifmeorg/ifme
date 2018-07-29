describe MeetingNotifications do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.first }

  context '#handle_members' do
    subject { described_class.handle_members(params) }
    let!(:group) { create :group }
    let!(:meeting) { create :meeting, group_id: group.id }
    let!(:member1) { create :meeting_member, user_id: user.id, leader: true, meeting_id: meeting.id }
    let!(:member2) { create :meeting_member, user_id: ally.id, leader: false, meeting_id: meeting.id }
    let!(:members) {  MeetingMember.where(meeting_id: meeting.id).all }
    let!(:uniqueid) { "#{type}_#{user.id}" }
    let!(:params) do
      {
        current_user: user,
        meeting: meeting,
        type: type,
        members: members
      }
    end

    context 'when type is remove_meeting' do
      let!(:type) { 'remove_meeting' }

      it 'works correctly' do
        expect(Notification.count).to eq(0)
        subject
        expect(Notification.count).to eq(1)
        expect(Notification.first.user_id).to eq(ally.id)
        expect(Notification.first.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.first.data)).to eq({
            'user' => user.name,
            'group_id' => group.id,
            'group' => group.name,
            'typename' => meeting.name,
            'type' => type,
            'uniqueid' => uniqueid,
        })
      end
    end

    context 'when type is new_meeting' do
      let!(:type) { 'new_meeting' }

      it 'works correctly' do
        type = 'new_meeting'
        expect(Notification.count).to eq(0)
        subject
        expect(Notification.count).to eq(1)
        expect(Notification.first.user_id).to eq(ally.id)
        expect(Notification.first.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.first.data)).to eq({
            'user' => user.name,
            'typeid' => meeting.id,
            'group' => group.name,
            'typename' => meeting.name,
            'type' => type,
            'uniqueid' => uniqueid,
        })
      end
    end

    context 'when type is update_meeting' do
      let!(:type) { 'update_meeting' }

      it 'works correctly' do
        expect(Notification.count).to eq(0)
        subject
        expect(Notification.count).to eq(1)
        expect(Notification.first.user_id).to eq(ally.id)
        expect(Notification.first.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.first.data)).to eq({
            'user' => user.name,
            'typeid' => meeting.id,
            'group' => group.name,
            'typename' => meeting.name,
            'type' => type,
            'uniqueid' => uniqueid,
        })
      end
    end
  end
end