RSpec.describe AccessToken, type: :helper do
  describe "#apply!" do
    it 'applies the access token to bearer' do
      foo = AccessToken.new("testToken")
      bar = {'Authorization' => ''}
      foo.apply!(bar)

      expect(bar['Authorization']).to eq('Bearer testToken')
    end
  end
end
