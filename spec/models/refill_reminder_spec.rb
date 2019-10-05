# frozen_string_literal: true

# == Schema Information
#
# Table name: perform_strategy_reminders
#
#  id          :integer          not null, primary key
#  strategy_id :integer          not null
#  active      :boolean          not null
#  created_at  :datetime
#  updated_at  :datetime
#
describe RefillReminder do
  context 'with relations' do
    it { is_expected.to belong_to :medication }
  end

  context '#name' do
    let(:reminder_name) { I18n.t('medications.refill_reminder') }
    let(:refill_reminder) { RefillReminder.new }

    it { expect(refill_reminder.name).to eq reminder_name }
  end
end
