# frozen_string_literal: true

describe CommentController do
  let(:user) { create(:user) }

  describe 'POST create' do
    let(:comment) { build(:comment, comment_by: user.id, commentable_type: commentable_type) }

    context 'from a moment' do
      let(:commentable) { create(:moment, user: user) }
      let(:commentable_type) { 'moment' }
      let(:valid_comment_params) do
        { comment: comment.attributes.merge(commentable_id: commentable.id, visibility: 'all') }
      end
      let(:invalid_comment_params) { { comment: comment.attributes } }

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment is saved' do
          it 'responds with an OK status' do
            post :create, params: valid_comment_params
            expect(response.status).to eq(200)
          end
        end

        context 'when the comment is not saved' do
          it 'renders correct response' do
            post :create, params: invalid_comment_params
            expect(response.body).to eq({}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before { post :create }
        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'from a strategy' do
      let(:commentable) { create(:strategy, user: user) }
      let(:commentable_type) { 'strategy' }
      let(:valid_comment_params) do
        { comment: comment.attributes.merge(commentable_id: commentable.id, visibility: 'all') }
      end
      let(:invalid_comment_params) { { comment: comment.attributes } }

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment is saved' do
          it 'responds with an OK status' do
            post :create, params: valid_comment_params
            expect(response.status).to eq(200)
          end
        end

        context 'when the comment is not saved' do
          it 'renders correct response' do
            post :create, params: invalid_comment_params
            expect(response.body).to eq({}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before { post :create }
        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'from a meeting' do
      let(:commentable) { create(:meeting) }
      let(:commentable_type) { 'meeting' }
      let(:valid_comment_params) do
        { comment: comment.attributes.merge(commentable_id: commentable.id) }
      end
      let(:invalid_comment_params) { { comment: comment.attributes } }

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment is saved' do
          it 'responds with an OK status' do
            post :create, params: valid_comment_params
            expect(response.status).to eq(200)
          end
        end

        context 'when the comment is not saved' do
          it 'renders correct response' do
            post :create, params: invalid_comment_params
            expect(response.body).to eq({}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before { post :create }

        it_behaves_like :with_no_logged_in_user
      end
    end
  end

  describe 'DELETE delete' do
    context 'from a moment' do
      let(:commentable_type) { 'moment' }

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment exists and belongs to the current_user' do
          let!(:commentable) { create(:moment, user_id: user.id) }
          let!(:comment) do
            create(
              :comment,
              comment_by: user.id,
              commentable_id: commentable.id,
              visibility: 'all',
              commentable_type: commentable_type
            )
          end

          it 'destroys the comment' do
            expect { delete :delete, params: { comment_id: comment.id } }.to(
              change(Comment, :count).by(-1)
            )
          end

          it 'renders correct response' do
            delete :delete, params: { comment_id: comment.id }
            expect(response.body).to eq({ id: comment.id }.to_json)
          end
        end

        context 'when the comment exists and the commentable belongs to the current_user' do
          let!(:commentable) { create(:moment, user_id: user.id) }
          let!(:comment) do
            create(
              :comment,
              comment_by: user.id,
              commentable_id: commentable.id,
              visibility: 'all',
              commentable_type: commentable_type
            )
          end

          it 'destroys the comment' do
            expect { delete :delete, params: { comment_id: comment.id } }.to(
              change(Comment, :count).by(-1)
            )
          end

          it 'renders correct response' do
            comment
            delete :delete, params: { comment_id: comment.id }
            expect(response.body).to eq({ id: comment.id }.to_json)
          end
        end

        context 'when the comment does not exist' do
          it 'renders correct response' do
            delete :delete, params: { comment_id: 0 }
            expect(response.body).to eq({}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before do
          delete :delete
        end
        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'from a strategy' do
      let(:commentable_type) { 'strategy' }

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment exists and belongs to the current_user' do
          let!(:commentable) { create(:strategy, user_id: user.id) }
          let!(:comment) do
            create(
              :comment,
              comment_by: user.id,
              commentable_id: commentable.id,
              visibility: 'all',
              commentable_type: commentable_type
            )
          end

          it 'destroys the comment' do
            expect { delete :delete, params: { comment_id: comment.id } }.to(
              change(Comment, :count).by(-1)
            )
          end

          it 'renders correct response' do
            delete :delete, params: { comment_id: comment.id }
            expect(response.body).to eq({ id: comment.id }.to_json)
          end
        end

        context 'when the comment exists and the commentable belongs to the current_user' do
          let!(:commentable) { create(:strategy, user_id: user.id) }
          let!(:comment) do
            create(
              :comment,
              comment_by: user.id,
              commentable_id: commentable.id,
              visibility: 'all',
              commentable_type: commentable_type
            )
          end

          it 'destroys the comment' do
            expect { delete :delete, params: { comment_id: comment.id } }.to(
              change(Comment, :count).by(-1)
            )
          end

          it 'renders correct response' do
            comment
            delete :delete, params: { comment_id: comment.id }
            expect(response.body).to eq({ id: comment.id }.to_json)
          end
        end

        context 'when the comment does not exist' do
          it 'renders correct response' do
            delete :delete, params: { comment_id: 0 }
            expect(response.body).to eq({}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before do
          delete :delete
        end
        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'from a meeting' do
      let(:commentable) { create(:meeting) }
      let(:commentable_type) { 'meeting' }
      let!(:meeting_member) do
        create(:meeting_member, meeting_id: commentable.id, user: user, leader: true)
      end
      let!(:comment) do
        create(
          :comment,
          comment_by: user.id,
          commentable_id: commentable.id,
          commentable_type: commentable_type,
          visibility: 'all'
        )
      end

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment exists and belongs to the current_user' do
          it 'destroys the comment' do
            expect { delete :delete, params: { comment_id: comment.id } }.to(
              change(Comment, :count).by(-1)
            )
          end

          it 'renders correct response' do
            delete :delete, params: { comment_id: comment.id }
            expect(response.body).to eq({ id: comment.id }.to_json)
          end
        end

        context 'when the comment exists and the commentable belongs to the current_user' do
          let!(:comment) do
            create(
              :comment,
              comment_by: user.id,
              commentable_id: commentable.id,
              visibility: 'all',
              commentable_type: commentable_type
            )
          end

          it 'destroys the comment' do
            expect { delete :delete, params: { comment_id: comment.id } }.to(
              change(Comment, :count).by(-1)
            )
          end

          it 'renders correct response' do
            comment
            delete :delete, params: { comment_id: comment.id }
            expect(response.body).to eq({ id: comment.id }.to_json)
          end
        end

        context 'when the comment does not exist' do
          it 'renders correct response' do
            delete :delete, params: { comment_id: 0 }
            expect(response.body).to eq({}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before do
          delete :delete
        end

        it_behaves_like :with_no_logged_in_user
      end
    end
  end
end
