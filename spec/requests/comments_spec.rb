# frozen_string_literal: true

describe 'Comments', type: :request do
  describe '#create' do
    context 'when a user is not signed in' do
      before { post comments_path }
      it_behaves_like :with_no_logged_in_user
    end

    context 'when a user is signed in' do
      subject { post comments_path, params: { comment: comment_params } }

      before { sign_in user }

      let(:user) { create(:user) }

      # Shared examples reduce repeated code
      shared_examples_for 'a comment is not created' do

        it { is_expected.to eq 400 }

        it 'returns an empty comment' do
          subject
          expect(JSON.parse(response.body)).to eq({})
        end
      end

      shared_examples_for 'a comment is succesfully created' do

        it { is_expected.to eq 200 }

        it { expect { subject }.to change { Comment.count }.by(1) }

        it 'returns the created comment' do
          subject
          expect(JSON.parse(response.body)['comment']['currentUserUid']).to eq(user.uid)
        end
      end

      context 'when creating a moment comment' do
        let(:comment_params) do
          attributes_for(
            :comment,
            commentable_type: 'moment',
            comment_by: user.id
          ).merge(relational_args)
        end

        context 'when provided valid arguments' do
          let(:relational_args) { { commentable_id: create(:moment, user: user).id } }

          it_behaves_like 'a comment is succesfully created'
        end

        context 'when provided invalid arguments' do
          let(:relational_args) { {} }

          it_behaves_like 'a comment is not created'
        end
      end

      context 'when creating a strategy comment' do
        let(:comment_params) do
          attributes_for(
            :comment,
            commentable_type: 'strategy',
            comment_by: user.id
          ).merge(relational_args)
        end

        context 'when provided valid arguments' do
          let(:relational_args) { { commentable_id: create(:strategy, user: user).id } }

          it_behaves_like 'a comment is succesfully created'
        end

        context 'when provided invalid arguments' do
          let(:relational_args) { {} }

          it_behaves_like 'a comment is not created'
        end
      end

      context 'when creating a meeting comment' do
        let(:comment_params) do
          attributes_for(
            :comment,
            commentable_type:
            'meeting',
            comment_by: user.id
          ).merge(relational_args)
        end

        context 'when provided valid arguments' do
          let(:relational_args) { { commentable_id: create(:meeting).id } }

          it_behaves_like 'a comment is succesfully created'
        end

        context 'when provided invalid arguments' do
          let(:relational_args) { {} }

          it_behaves_like 'a comment is not created'
        end
      end
    end
  end

  describe '#delete' do
    context 'when a user is not signed in' do
      before { delete delete_comments_path }
      it_behaves_like :with_no_logged_in_user
    end

    context 'when a user is signed in' do
      subject { delete delete_comments_path, params: { comment_id: comment_id } }

      before { sign_in user }

      let(:user) { create(:user) }

      # Shared examples reduce repeated code
      shared_examples_for 'a comment is not deleted' do

        it { is_expected.to eq 400 }

        it { expect { subject }.to change { Comment.count }.by(0) }

        it 'returns an empty body' do
          subject
          expect(JSON.parse(response.body)).to eq({})
        end
      end

      shared_examples_for 'a comment is succesfully deleted' do

        it { is_expected.to eq 200 }

        it { expect { subject }.to change { Comment.count }.by(-1) }

        it 'returns the deleted comments id' do
          subject
          expect(JSON.parse(response.body)['id']).to eq(comment_id)
        end
      end

      context 'when deleting a moment comment' do
        let(:moment) { create(:moment, user: commentable_user) }
        let!(:comment_id) do
          create(
            :comment,
            commentable_id: moment.id,
            commentable_type: 'moment',
            comment_by: current_user.id
          ).id
        end

        context 'with a valid id' do
          context 'when the comment exists' do
            context 'when the comment belongs to current_user' do
              # comment belongs to current_user, commentable by other user
              let(:current_user) { user }
              let(:commentable_user) { create(:user) }

              it_behaves_like 'a comment is succesfully deleted'
            end

            context 'when the comment belongs to commentable_user' do
              # comment belongs to other user, commentable by current_user
              let(:current_user) { create(:user) }
              let(:commentable_user) { user }

              it_behaves_like 'a comment is succesfully deleted'
            end

            context 'when the comment does not belong to current_user or commentable_user' do
              # comment and commentable do not belong to current_user or other_user
              let(:current_user) { create(:user) }
              let(:commentable_user) { create(:user) }

              it_behaves_like 'a comment is not deleted'
            end
          end

          context 'when the comment does not exist' do
            let(:comment_id) { 3 }

            it_behaves_like 'a comment is not deleted'
          end
        end

        context 'with an invalid id' do
          let(:comment_id) { -999 }

          it_behaves_like 'a comment is not deleted'
        end
      end

      context 'when deleting a strategy comment' do
        let(:strategy) { create(:strategy, user: commentable_user) }
        let!(:comment_id) do
          create(
            :comment,
            commentable_id: strategy.id,
            commentable_type: 'strategy',
            comment_by: current_user.id
          ).id
        end

        context 'with a valid id' do
          context 'when the comment exists' do
            context 'when the comment belongs to current_user' do
              # comment belongs to current_user, commentable by other user
              let(:current_user) { user }
              let(:commentable_user) { create(:user) }

              it_behaves_like 'a comment is succesfully deleted'
            end

            context 'when the comment belongs to commentable_user' do
              # comment belongs to other user, commentable by current_user
              let(:current_user) { create(:user) }
              let(:commentable_user) { user }

              it_behaves_like 'a comment is succesfully deleted'
            end

            context 'when the comment does not belong to current_user or commentable_user' do
              # comment and commentable do not belong to current_user or other_user
              let(:current_user) { create(:user) }
              let(:commentable_user) { create(:user) }

              it_behaves_like 'a comment is not deleted'
            end
          end

          context 'when the comment does not exist' do
            let(:comment_id) { 3 }

            it_behaves_like 'a comment is not deleted'
          end
        end

        context 'with an invalid id' do
          let(:comment_id) { -999 }

          it_behaves_like 'a comment is not deleted'
        end
      end

      context 'when deleting a meeting comment' do
        let(:current_user) { user }
        let(:meeting) { create(:meeting) }
        let(:member) do
          create(
            :meeting_member,
            meeting_id: meeting.id,
            user: current_user,
            leader: is_leader
          )
        end
        let!(:comment_id) do
          create(
            :comment,
            commentable_id: meeting.id,
            commentable_type: 'meeting',
            comment_by: current_user.id
          ).id
        end

        let(:comment_owner) {}
        let(:member_user) {}

        context 'with a valid id' do
          context 'when the comment exists' do
            context 'when comment belongs to current_user & is a member' do
              let(:is_leader) { false }
              let(:comment_owner) { current_user }
              before { member }

              it_behaves_like 'a comment is succesfully deleted'
            end

            context 'when current_user is meeting leader' do
              let(:is_leader) { true }
              let(:comment_owner) { create(:user) }
              before { member }

              it_behaves_like 'a comment is succesfully deleted'
            end

            context 'when comment does not belong to current_user & is not meeting leader' do
              let(:comment_owner) { create(:user) }

              it_behaves_like 'a comment is not deleted'
            end
          end

          context 'when the comment does not exist' do
            let(:comment_id) { 3 }

            it_behaves_like 'a comment is not deleted'
          end
        end

        context 'with an invalid id' do
          let(:comment_id) { -999 }

          it_behaves_like 'a comment is not deleted'
        end
      end
    end
  end
end
