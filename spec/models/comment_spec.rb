# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
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
		new_moment = create(:moment, userid: user1.id)
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
		new_moment = create(:moment, userid: user1.id)
	  new_comment = build(:comment, commentable_id: new_moment.id, visibility: 'all')
	  expect(new_comment).to have(1).error_on(:comment_by)
	end

	describe 'create_from!' do
		context 'Moments' do
			it 'posts a comment by the same user who created the Moment' do
				expect(Comment.count).to eq(0)
				new_moment = create(:moment, userid: user1.id)
			  new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
			  expect(Comment.count).to eq(1)
			end

			it 'posts a comment by a viewer of the Moment' do
				expect(Comment.count).to eq(0)
				new_moment = create(:moment, userid: user1.id, viewers: [user2.id])
			  new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
			  expect(Comment.count).to eq(1)
			end
		end

		context 'Strategies' do
			it 'posts a comment by the same user who created the Strategy' do
				expect(Comment.count).to eq(0)
				new_strategy = create(:strategy, userid: user1.id)
			  new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
			  expect(Comment.count).to eq(1)
			end

			it 'posts a comment by a viewer of the Strategy' do
				expect(Comment.count).to eq(0)
				new_strategy = create(:strategy, userid: user1.id, viewers: [user2.id])
			  new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
			  expect(Comment.count).to eq(1)
			end
		end

		context 'Meetings' do
			it 'posts a comment' do
				expect(Comment.count).to eq(0)
				new_meeting = create :meeting
				create :meeting_member, userid: user1.id, leader: true, meetingid: new_meeting.id
				new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user1.id, visibility: 'all')
			  expect(Comment.count).to eq(1)
			end
		end
	end

	describe 'notify_of_creation!' do
		context 'Moments' do
			it 'does not send a notification when the user created both the Moment and comment' do
				new_moment = create(:moment, userid: user1.id)
			  new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
			  new_comment.notify_of_creation!(user1)
				expect(Notification.count).to eq(0)
			end

			it 'sends a notification when a viewer comments on a Moment' do
				new_moment = create(:moment, userid: user1.id, viewers: [user2.id])
			  new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
			  new_comment.notify_of_creation!(user2)
				expect(Notification.count).to eq(1)
				expect(Notification.last.userid).to eq(user1.id)
				expect(Notification.last.uniqueid).to eq("comment_on_moment_#{new_comment.id}")
				expect(JSON.parse(Notification.last.data)).to eq({
					'user' => user2.name,
					'commentid' => new_comment.id,
					'comment' => long_comment[0..80],
					'cutoff' => true,
					'type' => 'comment_on_moment',
					'uniqueid' => "comment_on_moment_#{new_comment.id}",
					'momentid' => new_moment.id,
					'moment' => new_moment.name
				})
			end
		end

		context 'Strategies' do
			it 'does not send a notification when the user created both the Strategy and comment' do
				new_strategy = create(:strategy, userid: user1.id)
			  new_comment = Comment.create_from!(comment: short_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
			  new_comment.notify_of_creation!(user1)
				expect(Notification.count).to eq(0)
			end

			it 'sends a notification when a viewer comments on a Strategy' do
				new_strategy = create(:strategy, userid: user1.id, viewers: [user2.id])
			  new_comment = Comment.create_from!(comment: long_comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
			  new_comment.notify_of_creation!(user2)
				expect(Notification.count).to eq(1)
				expect(Notification.last.userid).to eq(user1.id)
				expect(Notification.last.uniqueid).to eq("comment_on_strategy_#{new_comment.id}")
				expect(JSON.parse(Notification.last.data)).to eq({
					'user' => user2.name,
					'commentid' => new_comment.id,
					'comment' => long_comment[0..80],
					'cutoff' => true,
					'type' => 'comment_on_strategy',
					'uniqueid' => "comment_on_strategy_#{new_comment.id}",
					'strategyid' => new_strategy.id,
					'strategy' => new_strategy.name
				})
			end
		end

		context 'Meetings' do
			it 'sends notifications to all Meeting members excluding the commenter who is a member' do
				new_group = create :group
				new_meeting = create :meeting, groupid: new_group.id
				create :meeting_member, userid: user1.id, leader: true, meetingid: new_meeting.id
				create :meeting_member, userid: user2.id, leader: false, meetingid: new_meeting.id
				create :meeting_member, userid: user3.id, leader: false, meetingid: new_meeting.id
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
					'meetingid' => new_meeting.id,
					'meeting' => new_meeting.name
				}

				expect(Notification.first.userid).to eq(user1.id)
				expect(JSON.parse(Notification.first.data)).to eq(data)

				expect(Notification.last.userid).to eq(user2.id)
				expect(JSON.parse(Notification.last.data)).to eq(data)
			end
		end
	end
end
