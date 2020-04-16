describe ResourceRecommendation do
    let(:moment) {FactoryBot.build(:moment,
                                       name: 'SELF-INJURY@',
                                       why: 'text',
                                       fix: 'text' )}
  
    subject(:resources) { ResourceRecommendation.new(moment).resources}
  
    describe 'A test for resources method from ResourceRecommendation class' do
      it 'returns recommended resources based on moment keywords' do
        available_resource = [{'tags'=> ["self_injury"]}]
        allow(JSON).to receive(:parse) { available_resource }
        expect(resources).to eq(available_resource)
      end
      it 'does not return any matched resources' do
        available_resource2 = [{'tags'=> ['self_care', 'anonymous', 'ios', 'communities']}]
        allow(JSON).to receive(:parse) { available_resource2 }
        expect(resources).not_to eq(available_resource2)
      end
    end
  end