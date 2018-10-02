# frozen_string_literal: true

describe CalendarHelper do
  include CalendarHelper
  describe 'new_cal_refill_reminder_needed?' do
    let(:user) { FactoryBot.create(:user1) }
    let(:medication) { FactoryBot.create(:medication, user_id: user.id) }

    it 'when add_to_google_cal is true without a refill date' do
      medication.add_to_google_cal = true
      medication.refill = nil
      expect(new_cal_refill_reminder_needed?(medication)).to eq(nil)
    end

    it 'when add_to_google_cal is true with a refill date' do
      medication.add_to_google_cal = true
      medication.refill = Time.zone.now
      expect(new_cal_refill_reminder_needed?(medication)).to eq(true)
    end
  end
end
