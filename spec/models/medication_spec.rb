# frozen_string_literal: true

# == Schema Information
#
# Table name: medications
#
#  id                :integer          not null, primary key
#  name              :string
#  dosage            :integer
#  refill            :string
#  created_at        :datetime
#  updated_at        :datetime
#  userid            :integer
#  total             :integer
#  strength          :integer
#  strength_unit     :string
#  dosage_unit       :string
#  total_unit        :string
#  comments          :text
#  slug              :string
#  add_to_google_cal :boolean
#

describe Medication do
  describe '#active_reminders' do
    let(:user) { FactoryGirl.create(:user1) }

    subject { medication.active_reminders }

    describe 'when medication has no reminders' do
      let(:medication) { FactoryGirl.create(:medication, userid: user.id) }

      it 'is an empty list' do
        expect(subject).to eq([])
      end
    end

    describe 'when medication has refill reminder' do
      let(:medication) { FactoryGirl.create(:medication, :with_refill_reminder, userid: user.id) }

      it 'is a list containing the refill reminder' do
        expect(subject).to eq([medication.refill_reminder])
      end
    end

    describe 'when medication has daily reminder' do
      let(:medication) { FactoryGirl.create(:medication, :with_daily_reminder, userid: user.id) }

      it 'is a list containing the daily reminder' do
        expect(subject).to eq([medication.take_medication_reminder])
      end
    end

    describe 'when medication has both reminders' do
      let(:medication) { FactoryGirl.create(:medication, :with_both_reminders, userid: user.id) }

      it 'is a list containing both reminders' do
        expect(subject).to eq([medication.refill_reminder, medication.take_medication_reminder])
      end
    end
  end

  describe '#new_cal_refill_reminder_needed?' do
    let(:user) { FactoryGirl.create(:user1) }
    let(:medication) { FactoryGirl.create(:medication, userid: user.id) }

    it 'when add_to_google_cal is true without a refill date' do
      medication.add_to_google_cal = true
      medication.refill = nil
      expect(medication.new_cal_refill_reminder_needed?).to eq(false)
    end

    it 'when add_to_google_cal is true with a refill date' do
      medication.add_to_google_cal = true
      medication.refill = Time.zone.now
      expect(medication.new_cal_refill_reminder_needed?).to eq(true)
    end
  end
end
