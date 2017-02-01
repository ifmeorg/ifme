RSpec.describe "Letsencrypt management", :type => :request do
  describe 'Letsencrypt middleware gem' do
    it 'should capture .well-known/acem-challenge values from ENV[\'ACME_CHALLENGE_FILENAME\']' do
      get '/.well-known/acme-challenge/test'

      expect(response).to be_success
      expect(response.body).to eq "test.success"
    end
  end
end