RSpec.describe MeetingsController, type: :controller do
  describe 'without being logged in' do
    subject { controller }
      # TODO: implement session controller
      # it_behaves_like 'LoggedOut'
    describe 'GET' do
      %w(join leave).each do |action|
        it "#{action} redirects to login" do
          get action

          expect(response).to redirect_to('/users/sign_in')
        end
      end
    end
  end
end
