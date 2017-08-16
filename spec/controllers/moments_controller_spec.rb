# frozen_string_literal: true

describe MomentsController do
  context 'when signed in' do
    let(:user) { create(:user) }
    let(:moment) { build(:moment, user: user) }

    before { sign_in user }

    it 'GET index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'POST new' do
      get :new
      expect(response).to render_template(:new)
      expect{ post :create, params: { moment: moment.attributes } }
        .to(change(Moment, :count).by(1))
    end

    it 'GET show' do
      moment.save!
      get :show, params: { id: moment.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST comment' do
    let(:user) { create(:user) }
    let(:moment) { create(:moment, user: user) }
    let(:comment) { build(:comment, comment_by: user.id) }
    let(:valid_comment_params) do
      comment.attributes.merge(commented_on: moment.id, visibility: 'all')
    end
    let(:invalid_comment_params) { comment.attributes }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment is saved' do
        it 'responds with an OK status' do
          post :comment, params: valid_comment_params
          expect(response.status).to eq(200)
        end
      end

      context 'when the comment is not saved' do
        it 'responds with json no_save: true' do
          post :comment, params: invalid_comment_params
          expect(response.body).to eq({ no_save: true }.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :comment }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET delete_comment' do
    let(:user) { create(:user, id: 1) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment exists and belongs to the current_user' do
        let!(:new_moment) { create(:moment, id: 1, userid: 1) }
        let!(:comment) do
          create(
            :comment, id: 1, comment_by: 1, commented_on: 1, visibility: 'all'
          )
        end

        it 'destroys the comment' do
          expect { get :delete_comment, params: { commentid: 1 } }.to(
            change(Comment, :count).by(-1)
          )
        end

        it 'renders nothing' do
          get :delete_comment, params: { commentid: 1 }

          expect(response.body).to eq('')
        end
      end

      context 'when the comment exists and the strategy belongs to the current_user' do
        let!(:comment) do
          create(
            :comment, id: 1, comment_by: 1, commented_on: 1, visibility: 'all'
          )
        end
        let!(:new_moment) { create(:moment, id: 1, userid: 1) }

        it 'destroys the comment' do
          expect { get :delete_comment, params: { commentid: 1 } }.to(
            change(Comment, :count).by(-1)
          )
        end

        it 'renders nothing' do
          comment
          get :delete_comment, params: { commentid: 1 }

          expect(response.body).to eq('')
        end
      end

      context 'when the comment does not exist' do
        it 'renders nothing' do
          get :delete_comment, params: { commentid: 1 }

          expect(response.body).to eq('')
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        get :delete_comment
      end

      it_behaves_like :with_no_logged_in_user
    end
  end
end
