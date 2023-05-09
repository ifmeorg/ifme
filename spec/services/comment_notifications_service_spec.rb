# frozen_string_literal: true

describe CommentNotificationsService do
  let(:user) { create :user2, :with_allies }
  let(:ally) { user.allies.first }

  context '#remove' do
    let!(:params) do
      {
        comment_id: comment.id,
        model_name: model_name
      }
    end

    context 'when model_name is moment' do
      let!(:model_name) { 'Moment' }
      let!(:moment) { create(:moment, user_id: user.id, viewers: [ally.id]) }
      let!(:comment) do
        Comment.create_from!(comment: 'Hello', commentable_type: model_name, commentable_id: moment.id, comment_by: ally.id,
                             visibility: visibility)
      end

      context 'when comment visibility is all' do
        let!(:visibility) { 'all' }

        it 'remove comments and notifications related to that moment' do
          comment.notify_of_creation!(ally)
          expect(Comment.count).to eq(1)
          expect(Notification.count).to eq(1)
          described_class
            .new(comment_id: comment.id, model_name: 'Moment').remove
          expect(Comment.count).to eq(0)
          expect(Notification.count).to eq(0)
        end
      end

      context 'when comment visibility is private' do
        let!(:visibility) { 'private' }

        it 'remove comments and notifications related to that moment' do
          comment.notify_of_creation!(ally)
          expect(Comment.count).to eq(1)
          expect(Notification.count).to eq(1)
          described_class
            .new(comment_id: comment.id, model_name: 'Moment').remove
          expect(Comment.count).to eq(0)
          expect(Notification.count).to eq(0)
        end
      end
    end

    context 'when model_name is strategy' do
      let!(:model_name) { 'Strategy' }
      let!(:strategy) { create(:strategy, user_id: user.id, viewers: [ally.id]) }
      let!(:comment) do
        Comment.create_from!(comment: 'Hello', commentable_type: model_name, commentable_id: strategy.id, comment_by: ally.id,
                             visibility: visibility)
      end

      context 'when comment visibility is all' do
        let!(:visibility) { 'all' }

        it 'remove comments and notifications related to that strategy' do
          comment.notify_of_creation!(ally)
          expect(Comment.count).to eq(1)
          expect(Notification.count).to eq(1)
          described_class
            .new(comment_id: comment.id, model_name: 'Strategy').remove
          expect(Comment.count).to eq(0)
          expect(Notification.count).to eq(0)
        end
      end

      context 'when comment visibility is private' do
        let!(:visibility) { 'private' }

        it 'remove comments and notifications related to that strategy' do
          comment.notify_of_creation!(ally)
          expect(Comment.count).to eq(1)
          expect(Notification.count).to eq(1)
          described_class
            .new(comment_id: comment.id, model_name: 'Strategy').remove
          expect(Comment.count).to eq(0)
          expect(Notification.count).to eq(0)
        end
      end
    end

    context 'when model_name is meeting' do
      let!(:model_name) { 'Meeting' }
      let!(:group) { create :group }
      let!(:meeting) { create :meeting, group_id: group.id }
      let!(:member1) { create :meeting_member, user_id: user.id, leader: true, meeting_id: meeting.id }
      let!(:member2) { create :meeting_member, user_id: ally.id, leader: false, meeting_id: meeting.id }
      let!(:comment) do
        Comment.create_from!(comment: 'Hello', commentable_type: model_name, commentable_id: meeting.id, comment_by: ally.id,
                             visibility: 'all')
      end

      it 'remove comments and notifications related to that meeting' do
        comment.notify_of_creation!(ally)
        expect(Comment.count).to eq(1)
        expect(Notification.count).to eq(1)
        described_class
          .new(comment_id: comment.id, model_name: 'Meeting').remove
        expect(Comment.count).to eq(0)
        expect(Notification.count).to eq(0)
      end
    end
  end
end
