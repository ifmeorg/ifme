# frozen_string_literal: true
# == Schema Information
#
# Table name: medications
#
#  id                :bigint           not null, primary key
#  name              :string
#  dosage            :integer
#  refill            :datetime
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
#  weekly_dosage     :integer          default(["0", "1", "2", "3", "4", "5", "6"]), is an Array
#

describe Medication do
  it { is_expected.to respond_to :friendly_id }

  context 'with validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :dosage }
    it { is_expected.to validate_presence_of :refill }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :total }
    it { is_expected.to validate_presence_of :strength }
    it { is_expected.to validate_presence_of :dosage_unit }
    it { is_expected.to validate_presence_of :total_unit }
    it { is_expected.to validate_presence_of :strength_unit }
    it { is_expected.to validate_numericality_of(:dosage).is_greater_than_or_equal_to 0 }
    it { is_expected.to validate_numericality_of(:total).is_greater_than_or_equal_to 0 }
    it { is_expected.to validate_numericality_of(:strength).is_greater_than_or_equal_to 0 }
  end

  context 'with relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_one :take_medication_reminder }
    it { is_expected.to have_one :refill_reminder }
  end

  context 'with nested attributes' do
    it { is_expected.to accept_nested_attributes_for :take_medication_reminder }
    it { is_expected.to accept_nested_attributes_for :refill_reminder }
  end

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
  end

  describe 'daily?' do
    let(:user) { FactoryBot.create(:user1) }
    let(:weekly_medication) { FactoryBot.create(:medication, user_id: user.id, weekly_dosage: [1, 2, 3, 4]) }
    let(:daily_medication) { FactoryBot.create(:medication, user_id: user.id) }

    it 'is weekly medication' do
      expect(weekly_medication.daily?).to be false
    end

    it 'is daily medication' do
      expect(daily_medication.daily?).to be true
    end
  end
end
