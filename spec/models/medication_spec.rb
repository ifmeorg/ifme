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
#  user_id           :integer
#  total             :integer
#  strength          :integer
#  strength_unit     :string
#  dosage_unit       :string
#  total_unit        :string
#  comments          :text
#  slug              :string
#  add_to_google_cal :boolean          default(FALSE)
#  weekly_dosage      integer[]         [0, 1, 2, 3, 4, 5, 6]
#

describe Medication do
  describe '#active_reminders' do
    let(:user) { FactoryBot.create(:user1) }

    subject { medication.active_reminders }

    describe 'when medication has no reminders' do
      let(:medication) { FactoryBot.create(:medication, user_id: user.id) }

      it 'is an empty list' do
        expect(subject).to eq([])
      end
    end

    describe 'when medication has refill reminder' do
      let(:medication) do
        FactoryBot.create(:medication,
                          :with_refill_reminder,
                          user_id: user.id)
      end

      it 'is a list containing the refill reminder' do
        expect(subject).to eq([medication.refill_reminder])
      end
    end

    describe 'when medication has daily reminder' do
      let(:medication) do
        FactoryBot.create(:medication,
                          :with_daily_reminder,
                          user_id: user.id)
      end

      it 'is a list containing the daily reminder' do
        expect(subject).to eq([medication.take_medication_reminder])
      end
    end

    describe 'when medication has both reminders' do
      let(:medication) do
        FactoryBot.create(:medication,
                          :with_both_reminders,
                          user_id: user.id)
      end

      it 'is a list containing both reminders' do
        expect(subject).to eq([medication.refill_reminder,
                               medication.take_medication_reminder])
      end
    end

    describe 'dosage scope' do
      let(:daily_medication) do
        FactoryGirl.create(:medication, userid: user.id)        
      end
      let(:weekly_medication) do
        FactoryGirl.create(:medication, 
                            weekly_dosage: [1,3,5],
                            userid: user.id)          
      end
      describe 'daily_dosage' do
        it 'returns only daily_dosage' do
          expect(Medication.daily_dosage).to eq([daily_medication])
        end
      end
      describe 'weekly_dosage' do
        it 'returns only weekly_dosage' do
          expect(Medication.weekly_dosage).to eq([weekly_medication])
        end
      end
    end
  end
end
