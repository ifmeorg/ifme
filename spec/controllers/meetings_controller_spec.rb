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
        let(:user) { create(:user1) }
        let(:other_user) { create(:user2) }

        context 'when meeting is found' do
          context 'when user has joined the meeting' do
            it 'lists comments and renders #show' do
              group = create(:group)
              create(:group_member, group: group, user: user)
              meeting = create(:meeting, group: group)
              create(:meeting_member, meeting: meeting, user: user)

              expect_any_instance_of(
                Meeting
              ).to receive(:comments).and_call_original
              get(:show, params: { id: meeting.id })
              expect(response).to render_template(:show)
            end
          end

          context 'when user has not joined the meeting' do
            context "and user is a member of meeting's group" do
              it 'does not list comments and renders #show' do
                group = create(:group)
                create(:group_member, group: group, user: user)
                meeting = create(:meeting, group: group)

                expect_any_instance_of(Meeting).not_to receive(:comments)
                get(:show, params: { id: meeting.id })
                expect(response).to render_template(:show)
              end
            end

            context "and user is not a member of meeting's group" do
              it 'redirects to groups page' do
                group = create(:group)
                create(:group_member, group: group, user: other_user, leader: true)
                meeting = create(:meeting, group: group)

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
    let(:user) { create(:user1) }

    context 'when the user is not logged in' do
      before do
        group = create(:group)
        create(:group_member, group: group, user: user, leader: true)
        get :new, params: { group_id: group_member.group_id }
      end

      it { expect(response).to redirect_to new_user_session_path }
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'user is the group leader' do
        before do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          get :new, params: { group_id: group.id }
        end

        it { expect(response).to have_http_status(:ok) }
      end

      context 'user is not the leader' do
        before do
          group = create(:group)
          create(:group_member, group: group, user: user)
          get :new, params: { group_id: group.id }
        end

        it { expect(response).to redirect_to group_path(group_member.group_id) }
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user1) }

    context 'when the user is not logged in' do
      before do
        group = create(:group)
        create(:group_member, group: group, user: user)
        meeting = create(:meeting, group: group)
        get :edit, params: { id: meeting.id }
      end

      it_behaves_like :with_no_logged_in_user
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'user is the group leader' do
        before do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          meeting = create(:meeting, group: group)
          get :edit, params: { id: meeting.id }
        end

        it { expect(response).to have_http_status(:ok) }
      end

      context 'user is not the group leader' do
        it {
          group = create(:group)
          group_member = create(:group_member, group: group, user: user)
          meeting = create(:meeting, group: group)
          get :edit, params: { id: meeting.id }

          expect(response).to redirect_to group_path(group_member.group_id)
        }
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
      let(:user) { create(:user1) }

      context 'and is not the group leader' do
        it 'redirects to group page' do
          group = create(:group)
          create(:group_member, group: group, user: user)

          post(:create, params: { meeting: { group_id: group.id } })
          expect(response).to redirect_to group_path(group.id)
        end
      end

      context 'and is the group leader' do
        context 'and meeting parameters are valid' do
          it 'notifies group members, creates a meeting, sets the current user as meeting leader, and redirects the user to the group page' do
            group = create(:group)
            create(:group_member, group: group, user: user, leader: true)

            expect(MeetingNotificationsService).to receive(:handle_members)
            expect do
              post(:create, params: { meeting: build(:meeting, group: group).attributes })
            end.to change { group.meetings.count }.from(0).to(1)
            expect(group.meetings.first.led_by?(user)).to eq(true)
            expect(response).to redirect_to group_path(group.id)
          end
        end

        context 'and meeting parameters are invalid' do
          it 'does not save the meeting and renders #new' do
            group = create(:group)
            create(:group_member, group: group, user: user, leader: true)

            expect do
              post(:create, params: { meeting: { group_id: group.id } })
            end.to_not change { group.meetings.count }
            expect(response).to render_template(:new)
          end
        end
      end
    end
  end

  describe 'PATCH/PUT #update' do
    include_context(:logged_in_user)
    let(:user) { create(:user1) }

    context 'when meeting is found' do
      context 'and parameters are valid' do
        it 'notifies meeting members, updates meeting, and redirects the user to the meeting page' do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          meeting = create(:meeting, group: group)
          create(:meeting_member, meeting: meeting, user: user, leader: true)

          expect(MeetingNotificationsService).to receive(:handle_members)
          expect do
            patch(:update, params: { id: meeting.id, meeting: { name: 'new_name' } })
          end.to change { meeting.reload.name }.to('new_name')
          expect(response).to redirect_to meeting_path(meeting.reload.slug)
        end
      end

      context 'and parameters are invalid' do
        it 'renders #edit' do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          meeting = create(:meeting, group: group)
          create(:meeting_member, meeting: meeting, user: user, leader: true)

          patch(:update, params: { id: meeting.id, meeting: { name: '' } })
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
    let(:user) { create(:user1) }

    context 'when meeting is found' do
      it 'notifies meeting members, adds user to meeting members, and redirects the user to the meeting page' do
        group = create(:group)
        create(:group_member, group: group, user: user, leader: true)
        meeting = create(:meeting, group: group)

        expect(MeetingNotificationsService).to receive(:handle_members)
        expect do
          get(:join, params: { meeting_id: meeting.id })
        end.to change { meeting.members.first }.from(nil).to(user)
        expect(response).to redirect_to meeting_path(meeting.id)
      end

      context 'and user has already joined' do
        it 'redirects to group page' do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          meeting = create(:meeting, group: group)
          create(:meeting_member, meeting: meeting, user: user)

          get(:join, params: { meeting_id: meeting.id })
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end
    end
  end

  describe 'GET #leave' do
    include_context(:logged_in_user)
    let(:user) { create(:user1) }

    context 'when meeting is found' do
      it 'removes user from meeting and redirects to group page' do
        group = create(:group)
        create(:group_member, group: group, user: user, leader: true)
        meeting = create(:meeting, group: group)
        create(:meeting_member, meeting: meeting, user: user)

        expect do
          get(:leave, params: { meeting_id: meeting.id })
        end.to change { meeting.members.count }.from(1).to(0)
        expect(response).to redirect_to group_path(meeting.group.id)
      end

      context 'when user is the only leader' do
        it 'does not remove user and redirects to group page' do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          meeting = create(:meeting, group: group)
          create(:meeting_member, meeting: meeting, user: user, leader: true)

          expect do
            get(:leave, params: { meeting_id: meeting.id })
          end.not_to change { meeting.members.count }
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    include_context(:logged_in_user)
    let(:user) { create(:user1) }

    context 'when meeting is found' do
      context 'and user is not the meeting group leader' do
        it 'redirects to group page' do
          group = create(:group)
          create(:group_member, group: group, user: user)
          meeting = create(:meeting, group: group)
          create(:meeting_member, meeting: meeting, user: user)

          delete(:destroy, params: { id: meeting.id })
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end

      context 'and user is the meeting group leader' do
        it 'notifies meeting members, removes meeting members, removes the meeting, and redirects user to group page' do
          group = create(:group)
          create(:group_member, group: group, user: user, leader: true)
          meeting = create(:meeting, group: group)
          create(:meeting_member, meeting: meeting, user: user, leader: true)

          expect(MeetingNotificationsService).to receive(:handle_members)
          expect do
            delete(:destroy, params: { id: meeting.id })
          end.to change { meeting.members.count }.from(1).to(0). and change { Meeting.count }.by(-1)
          expect(response).to redirect_to group_path(meeting.group.id)
        end
      end
    end

    context 'when meeting is not found' do
      it 'redirects to groups page' do
        delete(:destroy, params: { id: 'inexistent_id' })
        expect(response).to redirect_to groups_path
      end
    end
  end
end
