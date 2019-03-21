describe PusherController do

  let(:user) { create(:user) }
  let(:pusher) { create(:pusher) }

  describe 'auth' do
    context 'when the user is logged in' do
      before { sign_in user }

    it 'renders pusher response notification' do
        get :auth
        expect(response).to render_template("auth")
      end
    end
  end
end
