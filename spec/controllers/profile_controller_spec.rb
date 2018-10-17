# frozen_string_literal: true

describe ProfileController do
  describe 'GET #index' do
    context 'when user is not logged in' do
      before { get :index, params: { 'uid': 'user-id' } }
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
end
