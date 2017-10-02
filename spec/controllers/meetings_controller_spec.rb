RSpec.describe MeetingsController, :type => :controller do
  describe 'without being logged in' do
    subject { controller }
      # TODO: implement session controller
      # it_behaves_like 'LoggedOut'
    describe 'GET' do
      %w(join leave comment delete_comment).each do |action|
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

            it { expect(assigns(:page_edit)).to eq edit_meeting_path(meeting) }
            it { expect(assigns(:page_tooltip)).to eq I18n.t('meetings.edit_meeting')}
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
          it { expect(response).to redirect_to(group_path(meeting.groupid)) }
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
end
