# frozen_string_literal: true
describe CommentFormHelper, type: :controller do
  controller(ApplicationController) do
  end

  describe '#comment_form_props' do
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2) }
    let(:user3) { create(:user3, banned: true) }
    let(:submit_input) do
      {
        id: 'submit',
        type: 'submit',
        value: 'Submit',
        dark: true
      }
    end

    def default_inputs(comment_by, commentable_id, commentable_type)
      [
        {
          id: 'comment_commentable_type',
          name: 'comment[commentable_type]',
          type: 'hidden',
          value: commentable_type
        },
        {
          id: 'comment_comment_by',
          name: 'comment[comment_by]',
          type: 'hidden',
          value: comment_by
        },
        {
          id: 'comment_commentable_id',
          name: 'comment[commentable_id]',
          type: 'hidden',
          value: commentable_id
        },
        {
          id: 'comment_comment',
          name: 'comment[comment]',
          type: 'textarea',
          dark: true,
          value: nil,
          required: true,
          label: 'Comment'
        },
      ]
    end

    def non_owner_inputs(commentable_type)
      {
        inputs: default_inputs(user1.id, commentable.id, commentable_type).concat([
          options: [
            {
              id: 'comment_visibility_all',
              label: 'Share with everyone',
              value: 'all'
            },
            {
              id: 'comment_visibility_private',
              label: 'Share with Plum Blossom only',
              value: 'private'
            }
          ],
          id: 'comment_visibility',
          name: 'comment[visibility]',
          type: 'select',
          value: 'all',
          dark: true
        ]).concat([submit_input]),
        action: comment_index_path,
        noFormTag: true
      }
    end

    def owner_has_no_viewers_inputs(commentable_type)
      {
        inputs: default_inputs(user1.id, commentable.id, commentable_type).concat([submit_input]),
        action: comment_index_path,
        noFormTag: true

      }
    end

    def owner_has_viewers_inputs(commentable_type)
      {
        inputs: default_inputs(user1.id, commentable.id, commentable_type).concat([
          options: [
            {
              id: 'comment_viewers_everyone',
              label: 'Share with everyone',
              value: ''
            },
            {
              id: "comment_viewers_#{user2.id}",
              label: 'Share with Plum Blossom only',
              value: user2.id
            }
          ],
          id: 'comment_viewers',
          name: 'comment[viewers]',
          type: 'select',
          value: '',
          dark: true
        ]).concat([submit_input]),
        action: comment_index_path,
        noFormTag: true
      }
    end

    subject { controller.comment_form_props(commentable, commentable_type) }

    before do
      allow(controller).to receive(:current_user).and_return(user1)
    end

    context 'commentable type is a moment' do
      let(:commentable_type) { 'moment' }

      context 'user is the commentable owner' do
        let(:commentable) { create(:moment, user_id: user1.id, comment: true, viewers: viewers) }

        context 'has no viewers' do
          let(:viewers) { nil }

          it 'returns correct props' do
            expect(subject).to eq(owner_has_no_viewers_inputs('moment'))
          end
        end

        context 'has viewers' do
          let(:viewers) { [user2.id, user3.id] }

          it 'returns correct props' do
            expect(subject).to eq(owner_has_viewers_inputs('moment'))
          end
        end
      end

      context 'user is not the commentable owner' do
        let(:commentable) { create(:moment, user_id: user2.id, comment: true, viewers: viewers) }

        context 'has no viewers' do
          let(:viewers) { nil }

          it 'returns correct props' do
            expect(subject).to eq(non_owner_inputs('moment'))
          end
        end

        context 'has viewers' do
          let(:viewers) { [user2.id, user3.id] }

          it 'returns correct props' do
            expect(subject).to eq(non_owner_inputs('moment'))
          end
        end
      end
    end

    context 'commentable type is a strategy' do
      let(:commentable_type) { 'strategy' }

      context 'user is the commentable owner' do
        let(:commentable) { create(:strategy, user_id: user1.id, comment: true, viewers: viewers) }

        context 'has no viewers' do
          let(:viewers) { nil }

          it 'returns correct props' do
            expect(subject).to eq(owner_has_no_viewers_inputs('strategy'))
          end
        end

        context 'has viewers' do
          let(:viewers) { [user2.id, user3.id] }

          it 'returns correct props' do
            expect(subject).to eq(owner_has_viewers_inputs('strategy'))
          end
        end
      end

      context 'user is not the commentable owner' do
        let(:commentable) { create(:strategy, user_id: user2.id, comment: true, viewers: viewers) }

        context 'has no viewers' do
          let(:viewers) { nil }

          it 'returns correct props' do
            expect(subject).to eq(non_owner_inputs('strategy'))
          end
        end

        context 'has viewers' do
          let(:viewers) { [user2.id, user3.id] }

          it 'returns correct props' do
            expect(subject).to eq(non_owner_inputs('strategy'))
          end
        end
      end
    end

    context 'commentable type is a meeting' do
      let(:commentable_type) { 'meeting' }

      context 'user is a meeting leader' do
        let(:commentable) { create(:meeting) }
        let(:meeting_members) { create(:meeting_members, user_id: user1.id, meeting_id: commentable.id, leader: true)}

        it 'returns correct props' do
          expect(subject).to eq(owner_has_no_viewers_inputs('meeting'))
        end
      end

      context 'user is not a meeting leader' do
        let(:commentable) { create(:meeting) }
        let(:meeting_members) { create(:meeting_members, user_id: user1.id, meeting_id: commentable.id, leader: false)}

        it 'returns correct props' do
          expect(subject).to eq(owner_has_no_viewers_inputs('meeting'))
        end
      end
    end
  end
end
