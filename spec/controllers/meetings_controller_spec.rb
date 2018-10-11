# frozen_string_literal: true

RSpec.describe MeetingsController, type: :controller do
  describe 'without being logged in' do
    subject { controller }
    # TODO: implement session controller
    # it_behaves_like 'LoggedOut'
    describe 'GET' do
      %w[join leave comment delete_comment].each do |action|
        it "#{action} redirects to login" do
          get action

          expect(response).to redirect_to('/users/sign_in')
        end
      end
    end

    describe 'GET #show' do
      let!(:meeting) { create(:meeting) }
      let(:user) { create(:user) }
      let!(:meeting_member) do
        create(:meeting_member, user: user, meeting: meeting)
      end

      context 'when user is logged in' do
        before { sign_in user }

        context 'included in the meeting' do
          context 'as member' do
            before { get :show, params: { id: meeting.id } }

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:show) }
          end

          context 'as leader' do
            before do
              meeting_member.update(leader: true)
              get :show, params: { id: meeting.id }
            end

            it { expect(response).to have_http_status(:ok) }
            it { expect(response).to render_template(:show) }
          end
        end

        context 'not included in the meeting' do
          before do
            meeting_member.destroy
            get :show, params: { id: meeting.id }
          end

          it { expect(response).to have_http_status(:redirect) }
          it { expect(response).to redirect_to(groups_path) }
        end

        context 'inexistent meeting id' do
          before { get :show, params: { id: 111 } }

          it { expect(response).to have_http_status(:redirect) }
          it { expect(response).to redirect_to(groups_path) }
        end
      end

      context 'when user is logged out' do
        before { get :show, params: { id: meeting.id } }

        it_behaves_like :with_no_logged_in_user
      end
    end
  end

  describe 'POST #comment' do
    let(:user) { create(:user) }
    let(:meeting) { create(:meeting) }
    let(:comment) { build(:comment, comment_by: user.id, commentable_type: 'meeting') }
    let(:valid_comment_params) do
      { comment: comment.attributes.merge(commentable_id: meeting.id) }
    end
    let(:invalid_comment_params) { { comment: comment.attributes } }

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

  describe 'DELETE #delete_comment' do
    let(:user) { create(:user, id: 1) }
    let(:meeting) { create(:meeting, id: 1) }
    let!(:meeting_member) do
      create(:meeting_member, meeting: meeting, user: user, leader: true)
    end
    let!(:comment) do
      create(
        :comment,
        id: 1,
        comment_by: 1,
        commentable_id: 1,
        commentable_type: 'meeting',
        visibility: 'all'
      )
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment exists and belongs to the current_user' do
        it 'destroys the comment' do
          expect { delete :delete_comment, params: { comment_id: 1 } }.to(
            change(Comment, :count).by(-1)
          )
        end

        it 'renders nothing' do
          delete :delete_comment, params: { comment_id: 1 }

          expect(response.body).to eq('')
        end
      end

      context 'when the comment exists and the strategy belongs to the current_user' do
        let!(:comment) do
          create(
            :comment, id: 1, comment_by: 1, commentable_id: 1, visibility: 'all'
          )
        end

        let!(:new_moment) { create(:moment, id: 1, user_id: 1) }

        it 'destroys the comment' do
          expect { delete :delete_comment, params: { comment_id: 1 } }.to(
            change(Comment, :count).by(-1)
          )
        end

        it 'renders nothing' do
          comment
          delete :delete_comment, params: { comment_id: 1 }

          expect(response.body).to eq('')
        end
      end

      context 'when the comment does not exist' do
        it 'renders nothing' do
          delete :delete_comment, params: { comment_id: 99 }
          expect(response.body).to eq('')
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        delete :delete_comment
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #new' do
    let!(:user) { create(:user) }
    let!(:group_member) do
      create(:group_member, id: 1, user: user, leader: true)
    end

    context 'when the user is not logged in' do
      before do
        get :new, params: { group_id: group_member.group_id }
      end

      it { expect(response).to redirect_to new_user_session_path }
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'user is the group leader' do
        before do
          get :new, params: { group_id: group_member.group_id }
        end

        it { expect(response).to have_http_status(:ok) }
      end

      context 'user is not the leader' do
        before do
          group_member.update!(leader: false)
          get :new, params: { group_id: group_member.group_id }
        end

        it { expect(response).to redirect_to group_path(group_member.group_id) }
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) { create(:user, id: 1) }
    let(:meeting) { create(:meeting, id: 1) }
    let!(:group_member) { create(:group_member, group_id: meeting.group_id, id: 1, user: user, leader: true) }
    let(:meeting_member) { create(:meeting_member, user: user, meeting: meeting) }

    context 'when the user is not logged in' do
      before do
        get :edit, params: { id: meeting.id }
      end

      it_behaves_like :with_no_logged_in_user
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'user is the group leader' do
        before do
          get :edit, params: { id: meeting.id }
        end
        it { expect(response).to have_http_status(:ok) }
      end

      context 'user is not the group leader' do
        before do
          group_member.update!(leader: false)
          get :edit, params: { id: meeting.id }
        end

        it { expect(response).to redirect_to group_path(group_member.group_id) }
      end
    end
  end
end
