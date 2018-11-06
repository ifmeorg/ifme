# frozen_string_literal: true
describe ProfileController do
  describe '#index' do
    context 'when user is not logged in' do
      before { get :index, params: { uid: 'user-id' } }
      it { expect(response).to redirect_to(new_user_session_path) }
    end

    context 'when user is logged in' do
      let(:user1) { create(:user1) }
      before { stub_current_user_with(user1) }
      it 'renders index template' do
        get :index, params: { uid: user1.uid }
        expect(response).to render_template(:index)
      end

      context 'when profile belongs to logged in user' do
        it 'assigns profile instance to be that of logged in user' do
          get :index, params: { uid: user1.uid }
          expect(assigns(:profile)).to eq(user1)
        end

        context 'when user has no moments and strategies' do
          it 'assigns stories instance with an empty array' do
            get :index, params: { uid: user1.uid }
            expect(assigns(:stories)).to match_array([])
          end
        end

        context 'when user has moments or strategies' do
          it 'assigns stories instance with user moments or strategies' do
            stories = [build_stubbed(:moment), build_stubbed(:strategy)]
            allow_any_instance_of(ProfileController)
              .to receive(:get_stories).and_return(stories)
            get :index, params: { uid: user1.uid }
            expect(assigns(:stories)).to match_array(stories)
          end
        end
      end

      context 'when profile does not belong to user' do
        let(:profile_owner) { build_stubbed(:user2) }

        before do
          allow(User).to receive(:find_by).and_return(profile_owner)
          get :index, params: { uid: profile_owner.uid }
        end

        it 'does not assign stories' do
          expect(assigns(:stories)).to be_nil
        end

        it 'assigns profile instance to profile owner' do
          expect(assigns(:profile)).to eq(profile_owner)
        end
      end
    end
  end

  describe '#add_ban' do
    let(:user2) { create(:user2) }

    before(:each) { Devise.mailer.deliveries.clear }

    context 'when admin does not exist' do
      let(:user1) { create(:user1) }

      it 'cannot ban user' do
        sign_in user1
        post :add_ban, params: { user_id: user2.id }
        expect(response.status).to eq(204)
        expect(Devise.mailer.deliveries.count).to eq(0)
      end
    end

    context 'when admin exists' do
      let(:user1) { create(:user1, admin: true) }

      context 'when user exists' do
        it 'bans the user' do
          sign_in user1
          post :add_ban, params: { user_id: user2.id }
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:notice]).to eq("#{user2.name} has been banned")
          expect(Devise.mailer.deliveries.count).to eq(1)
        end
      end

      context 'when user does not exist' do
        it 'does not ban the user' do
          sign_in user1
          post :add_ban, params: { user_id: -1 }
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to eq('Could not ban -1')
          expect(Devise.mailer.deliveries.count).to eq(0)
        end
      end
    end
  end

  describe '#remove_ban' do
    let(:user2) { create(:user2, banned: true) }

    before(:each) { Devise.mailer.deliveries.clear }

    context 'when admin does not exist' do
      let(:user1) { create(:user1) }

      it 'cannot ban user' do
        sign_in user1
        post :remove_ban, params: { user_id: user2.id }
        expect(response.status).to eq(204)
        expect(Devise.mailer.deliveries.count).to eq(0)
      end
    end

    context 'when admin exists' do
      let(:user1) { create(:user1, admin: true) }

      context 'when user exists' do
        it 'removes ban' do
          sign_in user1
          post :remove_ban, params: { user_id: user2.id }
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:notice]).to eq("Ban removed on #{user2.name}")
          expect(Devise.mailer.deliveries.count).to eq(1)
        end
      end

      context 'when user does not exist' do
        it 'does not remove ban' do
          sign_in user1
          post :remove_ban, params: { user_id: -1 }
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to eq('Could not remove ban on -1')
          expect(Devise.mailer.deliveries.count).to eq(0)
        end
      end
    end
  end
end
