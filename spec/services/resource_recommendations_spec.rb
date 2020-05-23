describe ResourceRecommendations do
  let(:moment) { FactoryBot.build(:moment, name: 'SELF-INJURY@', why: 'text', fix: 'text' ) }
  let(:current_user) { create(:user2) }
  subject(:resources) { ResourceRecommendations.new(moment: moment, current_user: current_user).call}

  describe 'A test for resources method from ResourceRecommendations class' do
    it 'returns recommended resources based on moment keywords' do
      available_resource = [{'tags'=> ["self_injury"]}]
      allow(JSON).to receive(:parse) { available_resource }
      expect(resources).to eq(available_resource)
    end

    it 'does not return any matched resources' do
      available_resource2 = [{'tags'=> ['self-care', 'tech industry', 'anonymous', 'ios', 'communities']}]
      allow(JSON).to receive(:parse) { available_resource2 }
      expect(resources).not_to eq(available_resource2)
    end
  end
end
