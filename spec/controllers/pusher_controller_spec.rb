describe PusherController do

  let(:user) { create(:user) }

  describe 'auth' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'returns the pusher auth token in json' do
        post :auth, params: { channel_name: 'channel_one', socket_id: '123.456' }
        json = JSON.parse(response.body)

        expect(json['auth']).to_not be_nil
      end

      it 'returns an error if channel_name is not passed' do
        post :auth, params: { socket_id: '123.456' }
        json = JSON.parse(response.body)

        expect(response.code).to eq("400")
        expect(json['channel_name']).to eq([I18n.t('errors.empty_params')])
      end

      it 'returns an error if socket_id is not passed' do
        post :auth, params: { channel_name: 'channel_one' }
        json = JSON.parse(response.body)

        expect(response.code).to eq("400")
        expect(json['socket_id']).to eq([I18n.t('errors.empty_params')])
      end

      it 'returns an error if channel_name or socket_id is empty' do
        post :auth, params: { channel_name: '', socket_id: '' }
        json = JSON.parse(response.body)

        expect(response.code).to eq("400")
        expect(json['channel_name']).to eq([I18n.t('errors.empty_params')])
        expect(json['socket_id']).to eq([I18n.t('errors.empty_params')])
      end
    end

    context 'when the user is not logged in' do

      it 'returns a login redirect' do
        post :auth, params: { channel_name: 'channel_one', socket_id: '123.456' }

        expect(response.status).to eq(302)
      end
    end

  end
end
