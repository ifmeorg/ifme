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
      context 'when the user is not logged in' do
        before { post(:create) }
        it_behaves_like(:with_no_logged_in_user)
      end

      context 'when the user is logged in' do
        include_context(:logged_in_user)
        let(:user) { create(:user) }

        context 'when meeting is found' do
          let!(:meeting) { create(:meeting) }

          context 'when user has joined the meeting' do
            before do
              create(:meeting_member, user: user, meeting: meeting)
            end

            it 'renders #show' do
              get(:show, params: { id: meeting.id })
              expect(response).to render_template(:show)
            end

            it 'list comments' do
              expect_any_instance_of(
                Meeting
              ).to receive(:comments).and_call_original

              get(:show, params: { id: meeting.id })
            end
          end

          context 'when user has not joined the meeting' do
            context "and user is a member of meeting's group" do
              before do
                create(:group_member, user: user, group: meeting.group)
              end

              it 'renders #show' do
                get(:show, params: { id: meeting.id })
                expect(response).to render_template(:show)
              end

              it 'does not list comments' do
                expect_any_instance_of(Meeting).not_to receive(:comments)
                get(:show, params: { id: meeting.id })
              end
            end

            context "and user is not a member of meeting's group" do
              it 'redirects to groups page' do
                get(:show, params: { id: meeting.id })
                expect(response).to redirect_to groups_path
              end
            end
          end
        end

        context 'when meeting is not found' do
          it 'redirecs to groups page' do
            get(:show, params: { id: 'inexistent_id' })
            expect(response).to redirect_to groups_path
          end
        end
      end

      context 'when user is logged out' do
        before { get :show, params: { id: 'any_id' } }
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

  describe 'POST #create' do
    context 'when the user is not logged in' do
      before { post(:create) }
      it_behaves_like(:with_no_logged_in_user)
    end

    context 'when the user is logged in' do
      include_context(:logged_in_user)

      let(:user) { create(:user) }
      let(:group) do
        create(:group_with_member, user_id: user.id, leader: is_leader)
      end

      context 'and is not the group leader' do
        let(:is_leader) { false }

        it 'redirects to group page' do
          post(:create, params: { meeting: { group_id: group.id } })
          expect(response).to redirect_to group_path(group.id)
        end
      end

      context 'and is the group leader' do
        let(:is_leader) { true }

        context 'and meeting parameters are valid' do
          let(:params) do
            { meeting: build(:meeting, group: group).attributes }
          end

          it 'creates a meeting' do
            expect {
              post(:create, params: params)
            }.to change { group.meetings.count }.from(0).to(1)
          end

          it 'set current user as meeting leader' do
            post(:create, params: params)
            meeting = group.meetings.first

            expect(meeting.led_by?(user)).to eq(true)
          end

          it 'notifies group members' do
            expect(MeetingNotificationsService).to receive(:handle_members)
            post(:create, params: params)
          end

          it 'redirecs to group page' do
            post(:create, params: params)
            expect(response).to redirect_to group_path(group.id)
          end
        end

        context 'and meeting parameters are invalid' do
          let(:params) { { meeting: { group_id: group.id } } }

          it 'does not save the meeting' do
            expect {
              post(:create, params: params)
            }.to_not change { group.meetings.count }
          end

          it 'renders #new' do
            post(:create, params: params)
            expect(response).to render_template(:new)
          end
        end
      end
    end
  end

  describe 'PATCH/PUT #update' do
    include_context(:logged_in_user)
    let(:user) { create(:user) }

    context 'when meeting is found' do
      let!(:meeting) { create(:meeting) }

      context 'and parameters are valid' do
        let(:params) do
          { id: meeting.id, meeting: { name: 'new_name' } }
        end

        it 'updates meeting' do
          expect {
            patch(:update, params: params)
          }.to change { meeting.reload.name }.to('new_name')
        end

        it 'notifies meeting members' do
          expect(MeetingNotificationsService).to receive(:handle_members)
          patch(:update, params: params)
        end

        it 'redirects to meeting page' do
          patch(:update, params: params)
          expect(response).to redirect_to meeting_path(meeting.reload.slug)
        end
      end

      context 'and parameters are invalid' do
        let(:params) do
          { id: meeting.id, meeting: { name: '' } }
        end

        it 'renders #edit' do
          patch(:update, params: params)
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'when meeting is not found' do
      it 'redirecs to groups page' do
        patch(:update, params: { id: 'inexistent_id' })
        expect(response).to redirect_to groups_path
      end
    end
  end

  describe 'GET #join' do
    include_context(:logged_in_user)
    let(:user) { create(:user) }

    context 'when meeting is found' do
      let!(:meeting) { create(:meeting) }

      it 'adds user to meeting members' do
        expect {
          get(:join, params: { meeting_id: meeting.id })
        }.to change { meeting.members.first }.from(nil).to(user)
      end

      it 'notifies meeting members' do
        expect(MeetingNotificationsService).to receive(:handle_members)
        get(:join, params: { meeting_id: meeting.id })
      end

      it 'redirects to meeting page' do
        get(:join, params: { meeting_id: meeting.id })
        expect(response).to redirect_to meeting_path(meeting.id)
      end

      context 'and user has already joined' do
        it 'redirects to group page' do
          create(:meeting_member, meeting: meeting, user: user)

          get(:join, params: { meeting_id: meeting.id })
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end
    end
  end

  describe 'GET #leave' do
    include_context(:logged_in_user)
    let(:user) { create(:user) }

    context 'when meeting is found' do
      let!(:meeting) { create(:meeting) }
      let!(:meeting_member) do
        create(:meeting_member, meeting: meeting, user: user)
      end

      it 'removes user from meeting' do
        expect {
          get(:leave, params: { meeting_id: meeting.id })
        }.to change { meeting.members.count }.from(1).to(0)
      end

      it 'redirects to group page' do
        get(:leave, params: { meeting_id: meeting.id })
        expect(response).to redirect_to group_path(meeting.group.id)
      end

      context 'when user is the only leader' do
        before { meeting_member.update_column(:leader, true) }

        it 'redirects to group page' do
          get(:leave, params: { meeting_id: meeting.id })
          expect(response).to redirect_to group_path(meeting.group.id)
        end

        it 'does not removes user' do
          expect {
            get(:leave, params: { meeting_id: meeting.id })
          }.not_to change { meeting.members.count }
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    include_context(:logged_in_user)
    let(:user) { create(:user) }

    context 'when meeting is found' do
      let!(:meeting) { create(:meeting, group: group) }
      let!(:meeting_member) do
        create(:meeting_member, meeting: meeting, user: user)
      end
      let(:group) do
        create(:group_with_member, user_id: user.id, leader: is_leader)
      end

      context 'and user is not the meeting group leader' do
        let(:is_leader) { false }

        it 'redirects to group page' do
          delete(:destroy, params: { id: meeting.id })
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end

      context 'and user is the meeting group leader' do
        let(:is_leader) { true }

        it 'notifies meeting members' do
          expect(MeetingNotificationsService).to receive(:handle_members)
          delete(:destroy, params: { id: meeting.id })
        end

        it 'removes meeting members' do
          expect {
            delete(:destroy, params: { id: meeting.id })
          }.to change { meeting.members.count }.from(1).to(0)
        end

        it 'destroys meeting' do
          expect {
            delete(:destroy, params: { id: meeting.id })
          }.to change { Meeting.count }.by(-1)
        end

        it 'redirects to group page' do
          delete(:destroy, params: { id: meeting.id })
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end
    end

    context 'when meeting is not found' do
      it 'redirecs to groups page' do
        delete(:destroy, params: { id: 'inexistent_id' })
        expect(response).to redirect_to groups_path
      end
    end
  end
end
