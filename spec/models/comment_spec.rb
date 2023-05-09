# frozen_string_literal: true
# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
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
  context 'with relations' do
    it { is_expected.to belong_to :commentable }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of :comment }
    it { is_expected.to validate_presence_of :commentable_id }
    it { is_expected.to validate_presence_of :comment_by }
    it do
      is_expected.to validate_length_of(:comment).is_at_least(0).is_at_most(1000)
    end
    it do
      is_expected.to validate_inclusion_of(:commentable_type).in_array(%w[Moment Strategy Meeting])
    end
    it do
      is_expected.to validate_inclusion_of(:visibility).in_array(%w[all private])
    end
  end

  context 'with serialize' do
    it { is_expected.to serialize(:viewers) }
  end

  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:user3) { create(:user3) }
  let(:short_comment) { 'Hello from the outside' }
  let(:long_comment) do
    'Pretty as a picture, Sweeter than a swisher. Mad cause I\'m cuter than the girl that\'s witchya. I can talk about it cause I know that I\'m pretty'
  end

  it 'posts a valid comment' do
    expect(Comment.count).to eq(0)
    new_moment = create(:moment, user_id: user1.id)
    new_comment = create(:comment, commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
    expect(new_comment.comment).to eq('Test Comment')
    expect(new_comment.commentable_type).to eq('Moment')
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
        Comment.create_from!(comment: short_comment, commentable_type: 'Moment',
                             commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end

      it 'posts a comment by a viewer of the Moment' do
        expect(Comment.count).to eq(0)
        new_moment = create(:moment, user_id: user1.id, viewers: [user2.id])
        Comment.create_from!(comment: short_comment, commentable_type: 'Moment',
                             commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end
    end

    context 'Strategies' do
      it 'posts a comment by the same user who created the Strategy' do
        expect(Comment.count).to eq(0)
        new_strategy = create(:strategy, user_id: user1.id)
        Comment.create_from!(comment: short_comment, commentable_type: 'Strategy',
                             commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end

      it 'posts a comment by a viewer of the Strategy' do
        expect(Comment.count).to eq(0)
        new_strategy = create(:strategy, user_id: user1.id, viewers: [user2.id])
        Comment.create_from!(comment: short_comment, commentable_type: 'Strategy',
                             commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end
    end

    context 'Meetings' do
      it 'posts a comment' do
        expect(Comment.count).to eq(0)
        new_meeting = create :meeting
        create :meeting_member, user_id: user1.id, leader: true, meeting_id: new_meeting.id
        Comment.create_from!(comment: short_comment, commentable_type: 'Meeting',
                             commentable_id: new_meeting.id, comment_by: user1.id, visibility: 'all')
        expect(Comment.count).to eq(1)
      end
    end
  end

  describe 'comments' do
    before do
      another_commentable = if %w[Strategy Moment].include?(commentable.class.name)
                              create(commentable.class.name.downcase.to_sym, user: user1)
                            else
                              create(:meeting)
                            end
      create(
        :comment,
        commentable: another_commentable,
        comment_by: user2.id,
        comment: short_comment,
        visibility: 'all'
      )
      create(
        :comment,
        commentable: commentable,
        comment_by: user2.id,
        comment: short_comment,
        visibility: 'all'
      )
    end

    context 'when commentable type is a moment' do
      let(:commentable) { create(:moment, comment: true, user: user1, viewers: [user2.id]) }
      let(:commentable_type) { 'Moment' }

      it 'returns correct number of comments' do
        # binding.pry

        expect(Comment.comments_from(commentable).count).to eq(1)
        expect(Comment.count).to eq(2)
      end
    end

    context 'when commentable type is a strategy' do
      let(:commentable) { create(:strategy, comment: true, user: user1, viewers: [user2.id]) }
      let(:commentable_type) { 'Strategy' }

      it 'returns correct number of comments' do
        expect(Comment.comments_from(commentable).count).to eq(1)
        expect(Comment.count).to eq(2)
      end
    end

    context 'when commentable type is a meeting' do
      let(:commentable) { create(:meeting) }
      let(:commentable_type) { 'Meeting' }

      it 'returns correct number of comments' do
        create :meeting_member, user: user1, leader: true, meeting_id: commentable.id
        expect(Comment.comments_from(commentable).count).to eq(1)
        expect(Comment.count).to eq(2)
      end
    end
  end

  describe 'notify_of_creation!' do
    context 'Moments' do
      it 'does not send a notification when the user created both the Moment and comment' do
        new_moment = create(:moment, user_id: user1.id)
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'Moment',
                                           commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
        new_comment.notify_of_creation!(user1)
        expect(Notification.count).to eq(0)
      end

      it 'sends a notification when a viewer comments on a Moment and visibility is all' do
        new_moment = create(:moment, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'Moment',
                                           commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_Moment_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'user_id' => user2.id,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_Moment',
          'uniqueid' => uniqueid,
          'typeid' => new_moment.id,
          'typename' => new_moment.name
        )
      end

      it 'sends a notification when a viewer comments on a Moment and visibility is private' do
        new_moment = create(:moment, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'Moment',
                                           commentable_id: new_moment.id, comment_by: user2.id, visibility: 'private')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_Moment_private_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'user_id' => user2.id,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_Moment_private',
          'uniqueid' => uniqueid,
          'typeid' => new_moment.id,
          'typename' => new_moment.name
        )
      end
    end

    context 'Strategies' do
      it 'does not send a notification when the user created both the Strategy and comment' do
        new_strategy = create(:strategy, user_id: user1.id)
        new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'Strategy',
                                           commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
        new_comment.notify_of_creation!(user1)
        expect(Notification.count).to eq(0)
      end

      it 'sends a notification when a viewer comments on a Strategy and visibility is all' do
        new_strategy = create(:strategy, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'Strategy',
                                           commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_Strategy_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'user_id' => user2.id,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_Strategy',
          'uniqueid' => uniqueid,
          'typeid' => new_strategy.id,
          'typename' => new_strategy.name
        )
      end

      it 'sends a notification when a viewer comments on a Strategy and visibility is private' do
        new_strategy = create(:strategy, user_id: user1.id, viewers: [user2.id])
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'Strategy',
                                           commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'private')
        new_comment.notify_of_creation!(user2)
        uniqueid = "comment_on_Strategy_private_#{new_comment.id}"
        expect(Notification.count).to eq(1)
        expect(Notification.last.user_id).to eq(user1.id)
        expect(Notification.last.uniqueid).to eq(uniqueid)
        expect(JSON.parse(Notification.last.data)).to eq(
          'user' => user2.name,
          'user_id' => user2.id,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_Strategy_private',
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
        new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'Meeting',
                                           commentable_id: new_meeting.id, comment_by: user3.id, visibility: 'all')
        new_comment.notify_of_creation!(user3)

        expect(Notification.count).to eq(2)

        data = {
          'user' => user3.name,
          'user_id' => user3.id,
          'commentid' => new_comment.id,
          'comment' => long_comment[0..80],
          'cutoff' => true,
          'type' => 'comment_on_Meeting',
          'uniqueid' => "comment_on_Meeting_#{new_comment.id}",
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
