describe MomentsHelper do
  let(:user) { FactoryBot.create(:user) }
  let(:moment) { FactoryBot.create(:moment, :with_secret_share, user: user) }

  describe '#secret_share_url_props' do
    it 'builds the correct input' do
      url = secret_share_url(moment.secret_share_identifier) || nil
      action = moment_path(moment)
      input = { inputs: [
          {
            id: 'secretShareLink',
            type: 'text',
            name: 'secretShareInput',
            readOnly: true,
            value: url,
            dark: true
          }
        ], action: action
      }
      expect(secret_share_url_props(moment)).to eq(input)
    end
  end
end
