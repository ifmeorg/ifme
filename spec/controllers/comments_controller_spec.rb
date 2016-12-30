require 'spec_helper'

RSpec.describe CommentsController, type: :controller do
  xcontext 'moments' do
    describe 'POST #create' do
      let(:user)          { create(:user, id: 1) }
      let!(:new_moment)    { create(:moment, id: 1, userid: 1) }
      let(:valid_comment_params) { attributes_for(:comment).merge(comment_by: 1, commented_on: 1, visibility: 'all') }
      let(:invalid_comment_params) { attributes_for(:comment, commented_on: 1)}

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment is saved' do
          it 'responds with an OK status' do
            post :create, valid_comment_params

            expect(response.status).to eq(200)
          end
        end

        context 'when the comment is not saved' do
          it 'responds with json no_save: true' do
            post :create, invalid_comment_params

            expect(response.body).to eq({no_save: true}.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before do
          post :create
        end

        it_behaves_like :with_no_logged_in_user
      end
    end
  end

  xcontext 'strategies' do
    describe 'POST #create' do
      let(:user) { create(:user, id: 1) }
      let!(:strategy1) { create(:strategy, id: 1, userid: 1) }
      let(:valid_comment_params) { FactoryGirl.attributes_for(:comment).merge(comment_by: 1, commented_on: 1, visibility: 'all') }
      let(:invalid_comment_params) { FactoryGirl.attributes_for(:comment, commented_on: 1) }

      context 'when the user is logged in' do
        include_context :logged_in_user

        context 'when the comment is saved' do
          it 'responds with an OK status' do
            post :create, valid_comment_params

            expect(response.status).to eq(200)
          end
        end

        context 'when the comment is not saved' do
          it 'responds with json no_save: true' do
            post :create, invalid_comment_params

            expect(response.body).to eq({ no_save: true }.to_json)
          end
        end
      end

      context 'when the user is not logged in' do
        before { post :create }

        it_behaves_like :with_no_logged_in_user
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when the user is logged in' do
      include_context :logged_in_user

      let(:user) { create(:user, id: 1) }
      let!(:comment) do
        create(:comment, comment_by: 1, commented_on: 1, visibility: 'all')
      end

      let(:instance) do
        Comments::StrategyService.new(comment: comment, user: user)
      end

      context 'with valid params' do
        it 'with klass needs to call correct service' do
          expect(Comments::StrategyService).to receive(:new)
            .with(comment: comment).and_return(instance)

          expect(instance).to receive(:delete)

          delete :destroy, id: comment.id, comment_type: 'strategy'
        end

        it 'without klass needs to call base service' do
          expect(Comments::BaseService).to receive(:new)
            .with(comment: comment).and_return(instance)

          expect(instance).to receive(:delete)

          delete :destroy, id: comment.id
        end

        it 'renders nothing' do
          delete :destroy, id: comment.id

          expect(response.body).to be_empty
        end
      end
    end
  end
end
