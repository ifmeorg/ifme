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

  describe '#has_crisis_keywords?' do
    context 'when the moment contains a crisis keyword' do
      let(:moment) { FactoryBot.build(:moment, why: 'I have been feeling suicidal lately.') }

      it 'returns true' do
        expect(resources.has_crisis_keywords?).to be true
      end
    end

    context 'when the moment does not contain crisis keywords' do
      let(:moment) { FactoryBot.build(:moment, why: 'I had a really good day today.') }

      it 'returns false' do
        expect(resources.has_crisis_keywords?).to be false
      end
    end

    context 'when the crisis keyword is in HTML (Pell editor output)' do
      let(:moment) { FactoryBot.build(:moment, why: '<p>Sometimes I think about <strong>dying</strong>.</p>') }

      it 'returns true after stripping HTML' do
        expect(resources.has_crisis_keywords?).to be true
      end
    end
  end
end
