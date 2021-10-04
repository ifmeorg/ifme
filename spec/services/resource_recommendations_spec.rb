describe ResourceRecommendations do
  let(:moment) { FactoryBot.build(:moment, name: 'SELF-INJURY@', why: 'text', fix: 'text' ) }
  let(:current_user) { create(:user2) }

  subject(:resources) { described_class.new(moment: moment, current_user: current_user) }

  describe '#call' do
    it 'responds with recommended resources based on moment keywords' do
      available_resource = [{'tags'=> ["self_injury"]}]
      allow(JSON).to receive(:parse) { available_resource }

      expect(resources.call).to eq(available_resource)
    end

    it 'does not return any matched resources' do
      available_resource = [{'tags'=> ['self-care', 'tech industry', 'anonymous', 'ios', 'communities']}]
      allow(JSON).to receive(:parse) { available_resource }

      expect(resources.call).not_to eq(available_resource)
    end
  end
end
