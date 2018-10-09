# frozen_string_literal: true

RSpec.describe OmniauthCallbacksController, type: :controller do
  describe 'GET #google_oauth2' do
    context 'when user is not logged in' do
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
          expect(controller).to redirect_to('/')
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
          expect(controller).to redirect_to('/')
        end  
      end
    end
  
    # context 'when user is logged in' do
    #   include_context :logged_in_user
    #   context 'when user don't have google_oauth2 authentication' do
    #     before(:each) do
    #       stub_env_for_omniauth

    #       user = User.create!(:email => 'user@example.com', :password => 'my_secret')
    #       sign_in user

    #       get :google_oauth2
    #     end

    #     it 'should add google_oauth2 authentication to current user' do
    #       user = User.where(:email => 'user@example.com').first
    #       user.should_not be_nil
    #       fb_authentication = user.authentications.where(:provider => 'google_oauth2').first
    #       fb_authentication.should_not be_nil
    #       fb_authentication.uid.should == '1234'
    #     end

    #     it { should be_user_signed_in }

    #     it { response.should redirect_to authentications_path }
        
    #     it { flash[:notice].should == 'Facebook is connected with your account.'}
    #   end
      
    #   context 'when user already connect with google_oauth2' do
    #     before(:each) do
    #       stub_env_for_omniauth
          
    #       user = User.create!(:email => 'ghost@nobody.com', :password => 'my_secret')
    #       user.authentications.create!(:provider => 'google_oauth2', :uid => '1234')
    #       sign_in user

    #       get :google_oauth2
    #     end
        
    #     it 'should not add new google_oauth2 authentication' do
    #       user = User.where(:email => 'ghost@nobody.com').first
    #       user.should_not be_nil
    #       fb_authentications = user.authentications.where(:provider => 'google_oauth2')
    #       fb_authentications.count.should == 1
    #     end
        
    #     it { should be_user_signed_in }
        
    #     it { flash[:notice].should == 'Signed in successfully.' }
        
    #     it { response.should redirect_to tasks_path }
        
    #   end
    # end
  end
end
