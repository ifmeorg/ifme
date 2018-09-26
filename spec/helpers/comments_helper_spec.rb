# frozen_string_literal: true

describe CommentsHelper, type: :controller do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  controller(ApplicationController) do
  end

  describe 'generate_comment' do
    let(:user3) { create(:user3) }
    let(:comment) { 'Hello from the outside' }

    def delete_comment(comment_id)
      %(<div class="delete_comment"><a id="delete_comment_#{comment_id}" class="delete_comment_button" href=""><i class="fa fa-times"></i></a></div>)
    end

    def comment_info(user)
      %(<a href="/profile?uid=#{controller.get_uid(user.id)}">#{user.name}</a> - less than a minute ago)
    end

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
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'private', viewers: [user2.id])
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: "Visible only between you and #{user2.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end

      context 'Comment posted by Moment viewer who is logged in' do
        before(:each) do
          sign_in user2
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'private', viewers: [user1.id])
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: "Visible only between you and #{user1.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
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
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'private', viewers: [user2.id])
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: "Visible only between you and #{user2.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end

      context 'Comment posted by Strategy viewer who is logged in' do
        before(:each) do
          sign_in user2
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'private', viewers: [user1.id])
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: "Visible only between you and #{user1.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
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
          expect(controller.generate_comment(new_comment, 'meeting')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end

      context 'Comment posted by Meeting member who is logged in' do
        it 'generates a valid comment object' do
          sign_in user2
          new_comment = create(:comment, comment: comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'meeting')).to include(
            commentid: new_comment.id,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end
    end
  end
end
