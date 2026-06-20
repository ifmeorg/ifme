describe "Users::Reports", type: :request do
  let(:user) { create(:user) }

  describe '#submit_request' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'creates a data download request' do
        post users_data_path
        expect(status).to eq(200)
        data_request = Users::DataRequest.last
        expect(JSON.parse(response.body)['request_id']).to eq(data_request.request_id)
        expect(user.id).to eq(data_request.user_id)
      end
    end

    context 'when the user is not logged in' do
      before { post users_data_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#fetch_request_status' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'fetches the status of data request with a blank request_id' do
        get users_data_status_path
        expect(status).to eq(400)
        expect(JSON.parse(response.body)).to have_key('error')
      end

      it 'fetches the status of data request with a random request_id' do
        params = { request_id: SecureRandom.uuid }
        get users_data_status_path, params: params
        expect(status).to eq(404)
        expect(JSON.parse(response.body)).to have_key('error')
      end

      it "creates a data request and then fetches it's status" do
        post users_data_path
        expect(status).to eq(200)
        params = { request_id: JSON.parse(response.body)['request_id'] }
        get users_data_status_path, params: params
        expect(status).to eq(200)
        expect(JSON.parse(response.body)['current_status']).to eq(Users::DataRequest::STATUS[:success])
      end
    end

    context 'when the user is not logged in' do
      before { get users_data_status_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#download_data' do
    context 'when the user is logged in' do
      before { sign_in user }

      it 'fetches the file with a blank request_id' do
        get users_data_download_path
        expect(status).to eq(400)
        expect(JSON.parse(response.body)).to have_key('error')
      end

      it 'fetches the file with a random request_id' do
        params = { request_id: SecureRandom.uuid }
        get users_data_download_path, params: params
        expect(status).to eq(404)
        expect(JSON.parse(response.body)).to have_key('error')
      end

      it 'returns 404 when file_data is missing for a successful request' do
        data_request = create(:successful_data_request, user:, file_data: nil)
        get users_data_download_path, params: { request_id: data_request.request_id }
        expect(status).to eq(404)
        expect(JSON.parse(response.body)).to have_key('error')
      end

      it "creates a data request and then fetches it's status and then fetches the file" do
        post users_data_path
        expect(status).to eq(200)
        params = { request_id: JSON.parse(response.body)['request_id'] }
        get users_data_status_path, params: params
        expect(status).to eq(200)
        expect(JSON.parse(response.body)).to have_key('current_status')
        get users_data_download_path, params: params
        expect(status).to eq(200)
        expect(response.content_type).to include('application/gzip')
        expect(response.headers['Content-Disposition']).to include('attachment')
        expect(response.headers['Content-Disposition']).to include('user_data.csv.gz')
        data_request = Users::DataRequest.find_by(request_id: params[:request_id])
        expect(data_request.file_data).to be_present
      end
    end

    context 'when the user is not logged in' do
      before { get users_data_download_path }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
