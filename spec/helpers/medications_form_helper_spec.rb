# frozen_string_literal: true

describe MedicationsFormHelper do
  let(:current_user) { create(:user) }
  let(:medication) { create(:medication, user: current_user) }

  before do
    @medication = medication
  end

  def get_field(field_name)
    @fields.find { |f| f[:id] == field_name }
  end

  describe '#common_fields' do
    before do
      @fields = common_fields
    end

    it 'returns common medication fields' do
      expect(get_field('medication_name')[:value]).to eq(medication.name)
      expect(get_field('medication_strength')[:value]).to eq(medication.strength)
      expect(get_field('medication_strength_unit')[:value]).to eq(medication.strength_unit)
      expect(get_field('medication_total')[:value]).to eq(medication.total)
      expect(get_field('medication_total_unit')[:value]).to eq(medication.total_unit)
      expect(get_field('medication_dosage')[:value]).to eq(medication.dosage)
      expect(get_field('medication_dosage_unit')[:value]).to eq(medication.dosage_unit)
      expect(get_field('medication_refill')[:value]).to eq(medication.refill)
      expect(get_field('medication_comments')[:value]).to eq(medication.comments)
    end

    context 'when refill reminder is active' do
      let(:medication) { create(:medication, :with_refill_reminder, user: current_user) }
      it 'sets a medication refill reminder' do
        @medication = medication
        expect(get_field('medication_refill_reminder_attributes')[:value]).to eq(true)
        expect(get_field('medication_refill_reminder_attributes_id')[:value]).to eq(medication.refill_reminder.id)
      end
    end

    context 'when take medication reminder is active' do
      let(:medication) { create(:medication, :with_daily_reminder, user: current_user) }
      it 'sets a medication take medication reminder' do
        @medication = medication
        expect(get_field('medication_take_medication_reminder_attributes')[:value]).to eq(true)
        expect(get_field('medication_take_medication_reminder_attributes_id')[:value]).to eq(medication.take_medication_reminder.id)
      end
    end
  end

  describe '#google_fields' do
    before do
      @fields = google_fields
    end

    it 'adds google field to common fields' do
      expect(get_field('medication_add_to_google_cal')[:value]).to eq(true)
    end
  end

  describe '#days_checkbox' do
    it 'returns weekly dosage checkboxes information' do
      weekdays = days_checkbox
      0.upto(6).each do |i|
        expect(weekdays[i][:id]).to eq("medication_weekly_dosage_#{i}")
        expect(weekdays[i][:checked]).to eq(medication.weekly_dosage.include?(i))
      end
    end
  end
end
