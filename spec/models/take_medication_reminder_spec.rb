# frozen_string_literal: true
# == Schema Information
#
# Table name: take_medication_reminders
#
#  id            :integer          not null, primary key
#  medication_id :integer          not null
#  active        :boolean          not null
#  created_at    :datetime
#  updated_at    :datetime
#

describe TakeMedicationReminder do
  let(:user) { FactoryBot.create(:user1) }
  let(:medication) { FactoryBot.create(:medication, user_id: user.id) }
  let(:reminder) {
    FactoryBot.create(:take_medication_reminder, medication_id: medication.id)
  }

  describe '#active_reminders' do
    it 'returns only active reminders' do
      expect(TakeMedicationReminder.active).to eq([reminder])
    end
  end

  describe 'scope for_day' do
    let!(:weekly_medication) {
      FactoryBot.create(:medication, user_id: user.id, weekly_dosage: [0,2,4,6])
    }
    let!(:weekly_medication2) {
      FactoryBot.create(:medication, user_id: user.id, weekly_dosage: [1,2,4,6])
    }

    context 'on passing 0 (Sunday) as arg' do
      it "returns the medication's reminder which has dosage on Sunday (0)" do
        expect(TakeMedicationReminder.for_day(0)).to eq(
          [weekly_medication.take_medication_reminder]
        )
      end
    end
  end
end
