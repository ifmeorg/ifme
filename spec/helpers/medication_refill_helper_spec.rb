describe MedicationRefillHelper do
  include MedicationRefillHelper
  describe "new_cal_refill_reminder_needed?" do
    let(:user) { FactoryGirl.create(:user1) }
    let(:medication) { FactoryGirl.create(:medication, userid: user.id) }

    it 'when add_to_google_cal is true without a refill date' do
      medication.add_to_google_cal = true
      medication.refill = nil
      expect(new_cal_refill_reminder_needed?(medication)).to eq(false)
    end

    it 'when add_to_google_cal is true with a refill date' do
      medication.add_to_google_cal = true
      medication.refill = Time.zone.now
      expect(new_cal_refill_reminder_needed?(medication)).to eq(true)
    end
  end
end
