# frozen_string_literal: true

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe 'GET #google_oauth2' do
    context 'when google_oauth2 email doesnt exist in the system' do
      let(:user) { User.find_by(email: 'example@xyze.it') }
      
      before do
        stub_env_for_omniauth
        get :google_oauth2
      end

      it 'creates user with info in google_oauth2' do
        expect(user.name).to eq 'Test User'
      end

      it 'should create authentication with google_oauth2' do
        expect(user.google_oauth2_enabled?).to eq true
      end

      it 'should sign in the user and redirect_to root' do
        expect(subject.current_user).to eq user
        expect(response).to redirect_to('/')
      end
    end
    
    context 'when google_oauth2 email already exist in the system' do
      let!(:user) { create(:user, email: 'example@xyze.it') }
      
      before do
        stub_env_for_omniauth
        get :google_oauth2
      end

      it 'updates the user with google_oauth2 credentials' do
        expect(user.reload.token).to eq 'abcdefg12345'
      end

      it 'should create authentication with google_oauth2' do
        expect(user.reload.google_oauth2_enabled?).to eq true
      end

      it 'should sign in the user and redirect_to root' do
        expect(subject.current_user).to eq user
        expect(response).to redirect_to('/')
      end  
    end

    context 'when google_oauth2 enabling fails' do
      before do
        stub_env_for_omniauth
        allow(User).to receive(:find_for_google_oauth2)
          .with(request.env["omniauth.auth"], nil).and_return(nil)
        get :google_oauth2
      end

      it 'redirects to sign in path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end 
  end
end
