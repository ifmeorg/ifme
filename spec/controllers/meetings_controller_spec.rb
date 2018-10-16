# frozen_string_literal: true

RSpec.describe MeetingsController, type: :controller do
  describe 'without being logged in' do
    subject { controller }
    # TODO: implement session controller
    # it_behaves_like 'LoggedOut'
    describe 'GET' do
      %w[join leave].each do |action|
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
