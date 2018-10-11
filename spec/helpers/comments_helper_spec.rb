# frozen_string_literal: true

describe CommentsHelper, type: :controller do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  controller(ApplicationController) do
  end

  describe '#generate_comments' do
    let(:user3) { create(:user3) }
    let(:comment) { 'Hello from the outside' }
    let(:created_at) { 'Created less than a minute ago' }

    before do
      create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
      create(:allyships_accepted, user_id: user1.id, ally_id: user3.id)
    end

    context 'Moments' do
      let(:new_moment) { create(:moment, user_id: user1.id, viewers: [user2.id, user3.id]) }

      context 'Comment posted by Moment creator who is logged in' do
        before(:each) do
          sign_in user1
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user1.uid,
            commentByName: user1.name,
            commentByAvatar: user1.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: nil,
            deletable: true
          }])
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'private', viewers: [user2.id])
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user1.uid,
            commentByName: user1.name,
            commentByAvatar: user1.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: "Visible only between you and #{user2.name}",
            deletable: true
          }])
        end
      end

      context 'Comment posted by Moment viewer who is logged in' do
        before(:each) do
          sign_in user2
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user2.uid,
            commentByName: user2.name,
            commentByAvatar: user2.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: nil,
            deletable: true
          }])
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'private', viewers: [user1.id])
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user2.uid,
            commentByName: user2.name,
            commentByAvatar: user2.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: "Visible only between you and #{user1.name}",
            deletable: true
          }])
        end
      end
    end

    context 'Strategies' do
      let(:new_strategy) { create(:strategy, user_id: user1.id, viewers: [user2.id, user3.id]) }

      context 'Comment posted by Strategy creator who is logged in' do
        before(:each) do
          sign_in user1
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user1.uid,
            commentByName: user1.name,
            commentByAvatar: user1.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: nil,
            deletable: true
          }])
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'private', viewers: [user2.id])
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user1.uid,
            commentByName: user1.name,
            commentByAvatar: user1.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: "Visible only between you and #{user2.name}",
            deletable: true
          }])
        end
      end

      context 'Comment posted by Strategy viewer who is logged in' do
        before(:each) do
          sign_in user2
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user2.uid,
            commentByName: user2.name,
            commentByAvatar: user2.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: nil,
            deletable: true
          }])
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'private', viewers: [user1.id])
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user2.uid,
            commentByName: user2.name,
            commentByAvatar: user2.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: "Visible only between you and #{user1.name}",
            deletable: true
          }])
        end
      end
    end

    context 'Meetings' do
      let(:new_meeting) { create :meeting }

      before do
        create :meeting_member, user_id: user1.id, leader: true, meeting_id: new_meeting.id
        create :meeting_member, user_id: user2.id, leader: false, meeting_id: new_meeting.id
      end

      context 'Comment posted by Meeting creator who is logged in' do
        it 'generates a valid comment object' do
          sign_in user1
          new_comment = create(:comment, comment: comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user1.id, visibility: 'all')
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user1.uid,
            commentByName: user1.name,
            commentByAvatar: user1.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: nil,
            deletable: true
          }])
        end
      end

      context 'Comment posted by Meeting member who is logged in' do
        it 'generates a valid comment object' do
          sign_in user2
          new_comment = create(:comment, comment: comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comments(Comment.where(id: new_comment.id))).to eq([{
            id: new_comment.id,
            commentByUid: user2.uid,
            commentByName: user2.name,
            commentByAvatar: user2.avatar.url,
            comment: comment,
            createdAt: created_at,
            viewers: nil,
            deletable: true
          }])
        end
      end
    end
  end

  # describe '#show_with_comments' do

  # end
end
