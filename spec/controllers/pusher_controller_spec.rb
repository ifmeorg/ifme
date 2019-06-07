describe PusherController do

  let(:user) { create(:user) }

  describe 'auth' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'returns the pusher auth token in json' do
        post :auth, params: { channel_name: 'janessa', socket_id: '123.456' }
        json = JSON.parse(response.body)

        expect(json['auth']).to_not be_nil
      end
    end

    context 'when the user is not logged in' do

      it 'returns a login redirect' do
        post :auth, params: { channel_name: 'janessa', socket_id: '123.456' }

        expect(response.status).to eq(302)
      end
    end

  end
end
