describe UserBuilder::Base do
  describe '.call' do
    subject { described_class }

    let(:user_one) { FactoryBot.build(:user1) }

    let(:auth) { OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :info => info })
    }

    let(:info) do
      { name: 'joe', email: 'test@email.com' } 
    end

    let(:builder) { UserBuilder::Base.call(user: user_one, auth: auth) }

    it 'builds the user object' do
      expect(builder.user).to eql(user_one)
    end

    it 'creates correct user uid' do
      expect(builder.user.uid).to eql('github123545')
    end

    it 'creates user under provider' do
      expect(builder.user.provider).to eql('github')
    end
  end
end
