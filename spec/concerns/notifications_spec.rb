class NotificationsTestController < ApplicationController
    include Notifications
  end

  describe NotificationsTestController do
    let(:user) { create :user2, :with_allies }
    let(:ally) { user.allies.first }

    context '#delete_comment_and_notifications' do
      let(:moment) { create(:moment, user_id: user.id, viewers: [ally.id]) }

      it 'works correctly when comment visibility is all' do
        comment = Comment.create_from!(comment: 'Hello', commentable_type: 'moment', commentable_id: moment.id, comment_by: ally.id, visibility: 'all')
        comment.notify_of_creation!(ally)
        expect(Comment.count).to eq(1)
        expect(Notification.count).to eq(1)
        subject.delete_comment_and_notifications(comment.id, 'moment')
        expect(Comment.count).to eq(0)
        expect(Notification.count).to eq(0)
      end

      it 'works correctly when comment visibility is private' do
        comment = Comment.create_from!(comment: 'Hello', commentable_type: 'moment', commentable_id: moment.id, comment_by: ally.id, visibility: 'private')
        comment.notify_of_creation!(ally)
        expect(Comment.count).to eq(1)
        expect(Notification.count).to eq(1)
        subject.delete_comment_and_notifications(comment.id, 'moment')
        expect(Comment.count).to eq(0)
        expect(Notification.count).to eq(0)
      end
    end

    context '#notifications_for_meeting_members' do
      let(:group) { create :group }
      let(:meeting) { create :meeting, group_id: group.id }

      before do
        create :meeting_member, user_id: user.id, leader: true, meeting_id: meeting.id
        create :meeting_member, user_id: ally.id, leader: false, meeting_id: meeting.id
      end

      it 'works correctly when type is remove_meeting' do
        type = 'remove_meeting'
        uniqueid = "#{type}_#{user.id}"
        members = MeetingMember.where(meeting_id: meeting.id).all
        allow(subject).to receive(:current_user).and_return(user)
        expect(Notification.count).to eq(0)
        subject.notifications_for_meeting_members(meeting, members, type)
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

      it 'works correctly when type is new_meeting' do
        type = 'new_meeting'
        uniqueid = "#{type}_#{user.id}"
        members = MeetingMember.where(meeting_id: meeting.id).all
        allow(subject).to receive(:current_user).and_return(user)
        expect(Notification.count).to eq(0)
        subject.notifications_for_meeting_members(meeting, members, type)
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

      it 'works correctly when type is update_meeting' do
        type = 'update_meeting'
        uniqueid = "#{type}_#{user.id}"
        members = MeetingMember.where(meeting_id: meeting.id).all
        allow(subject).to receive(:current_user).and_return(user)
        expect(Notification.count).to eq(0)
        subject.notifications_for_meeting_members(meeting, members, type)
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