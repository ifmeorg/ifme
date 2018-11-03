# frozen_string_literal: true
# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  comment_by       :integer
#  comment          :text
#  created_at       :datetime
#  updated_at       :datetime
#  visibility       :string
#  viewers          :text
#

describe Comment do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:user3) { create(:user3) }
  let(:short_comment) { 'Hello from the outside' }
  let(:long_comment) { 'Pretty as a picture, Sweeter than a swisher. Mad cause I\'m cuter than the girl that\'s witchya. I can talk about it cause I know that I\'m pretty' }

  it 'posts a valid comment' do
    expect(Comment.count).to eq(0)
    new_moment = create(:moment, user_id: user1.id)
    new_comment = create(:comment, commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
    expect(new_comment.comment).to eq('Test Comment')
    expect(new_comment.commentable_type).to eq('moment')
    expect(new_comment.commentable_id).to eq(new_moment.id)
    expect(new_comment.comment_by).to eq(user1.id)
    expect(new_comment.visibility).to eq('all')
    expect(Comment.count).to eq(1)
  end

  it 'posts an invalid comment' do
    expect(Comment.count).to eq(0)
    new_moment = create(:moment, user_id: user1.id)
    new_comment = build(:comment, commentable_id: new_moment.id, visibility: 'all')
    expect(new_comment).to have(1).error_on(:comment_by)
  end

  describe 'create_from!' do
    context 'Moments' do
      it 'posts a comment by the same user who created the Moment' do
        expect(Comment.count).to eq(0)
        new_moment = create(:moment, user_id: user1.id)
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end

      it 'posts a comment by a viewer of the Moment' do
        expect(Comment.count).to eq(0)
        new_moment = create(:moment, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end
    end

    context 'Strategies' do
      it 'posts a comment by the same user who created the Strategy' do
        expect(Comment.count).to eq(0)
        new_strategy = create(:strategy, user_id: user1.id)
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end

      it 'posts a comment by a viewer of the Strategy' do
        expect(Comment.count).to eq(0)
        new_strategy = create(:strategy, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end
    end

    context 'Meetings' do
      it 'posts a comment' do
        expect(Comment.count).to eq(0)
        new_meeting = create :meeting
        create :meeting_member, user_id: user1.id, leader: true, meeting_id: new_meeting.id
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user1.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end
    end
  end

  describe 'comments' do
    before do
      create(
        :comment,
        commentable_id: 0,
        commentable_type: commentable_type,
        comment_by: user2.id,
        comment: short_comment,
        visibility: 'all'
      )
      create(
        :comment,
        commentable_id: commentable.id,
        commentable_type: commentable_type,
        comment_by: user2.id,
        comment: short_comment,
        visibility: 'all'
      )
    end

    context 'when commentable type is a moment' do
      let(:commentable) { create(:moment, comment: true, user_id: user1.id, viewers: [user2.id]) }
      let(:commentable_type) { 'moment' }

      it 'returns correct number of comments' do
        expect(Comment.comments_from(commentable).count).to eq(1)
        expect(Comment.count).to eq(2)
      end
    end

    context 'when commentable type is a strategy' do
      let(:commentable) { create(:strategy, comment: true, user_id: user1.id, viewers: [user2.id]) }
      let(:commentable_type) { 'strategy' }

      it 'returns correct number of comments' do
        expect(Comment.comments_from(commentable).count).to eq(1)
        expect(Comment.count).to eq(2)
      end
    end

    context 'when commentable type is a meeting' do
      let(:commentable) { create(:meeting) }
      let(:commentable_type) { 'meeting' }

      it 'returns correct number of comments' do
        create :meeting_member, user_id: user1.id, leader: true, meeting_id: commentable.id
        expect(Comment.comments_from(commentable).count).to eq(1)
        expect(Comment.count).to eq(2)
      end
    end
  end

  describe 'notify_of_creation!' do
    context 'Moments' do
      it 'does not send a notification when the user created both the Moment and comment' do
        new_moment = create(:moment, user_id: user1.id)
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
        new_comment.notify_of_creation!(user1)
        expect(Notification.count).to eq(0)
      end

      it 'sends a notification when a viewer comments on a Moment and visibility is all' do
        new_moment = create(:moment, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_moment_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_moment',
          'uniqueid' => uniqueid,
          'typeid' => new_moment.id,
          'typename' => new_moment.name
        )
      end

      it 'sends a notification when a viewer comments on a Moment and visibility is private' do
        new_moment = create(:moment, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'private')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_moment_private_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_moment_private',
          'uniqueid' => uniqueid,
          'typeid' => new_moment.id,
          'typename' => new_moment.name
        )
      end
    end

    context 'Strategies' do
      it 'does not send a notification when the user created both the Strategy and comment' do
        new_strategy = create(:strategy, user_id: user1.id)
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
        new_comment.notify_of_creation!(user1)
        expect(Notification.count).to eq(0)
      end

      it 'sends a notification when a viewer comments on a Strategy and visibility is all' do
        new_strategy = create(:strategy, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_strategy_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_strategy',
          'uniqueid' => uniqueid,
          'typeid' => new_strategy.id,
          'typename' => new_strategy.name
        )
      end

      it 'sends a notification when a viewer comments on a Strategy and visibility is private' do
        new_strategy = create(:strategy, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'private')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_strategy_private_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_strategy_private',
          'uniqueid' => uniqueid,
          'typeid' => new_strategy.id,
          'typename' => new_strategy.name
        )
      end
    end

    context 'Meetings' do
      it 'sends notifications to all Meeting members excluding the commenter who is a member' do
        new_group = create :group
        new_meeting = create :meeting, group_id: new_group.id
        create :meeting_member, user_id: user1.id, leader: true, meeting_id: new_meeting.id
        create :meeting_member, user_id: user2.id, leader: false, meeting_id: new_meeting.id
        create :meeting_member, user_id: user3.id, leader: false, meeting_id: new_meeting.id
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user3.id, visibility: 'all')
        new_comment.notify_of_creation!(user3)

        expect(Notification.count).to eq(2)

        data = {
          'user' => user3.name,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_meeting',
          'uniqueid' => "comment_on_meeting_#{new_comment.id}",
          'typeid' => new_meeting.id,
          'typename' => new_meeting.name
        }

        expect(Notification.first.user_id).to eq(user1.id)
        expect(JSON.parse(Notification.first.data)).to eq(data)

        expect(Notification.last.user_id).to eq(user2.id)
        expect(JSON.parse(Notification.last.data)).to eq(data)
      end
    end
  end
end
