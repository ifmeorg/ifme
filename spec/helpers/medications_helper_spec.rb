# frozen_string_literal: true

describe MedicationsHelper do
  let(:current_user) { create(:user) }
  let(:medication) { create(:medication, user: current_user) }

  before do
    @medication = medication
  end

  describe '#present_medication' do
    subject { present_medication(medication) }
    it 'returns correct data' do
      expect(subject.keys).to include(:name, :link, :actions, :medicationBody)
      expect(subject[:link]).to eq(medication_path(medication))
      expect(subject[:name]).to eq(medication[:name])
    end
  end
end
