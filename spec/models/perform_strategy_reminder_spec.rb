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
describe PerformStrategyReminder do
  context 'with relations' do
    it { is_expected.to belong_to :strategy }
  end

  context '#name' do
    let(:strategy_name) { I18n.t('common.daily_reminder') }
    let(:perform_strategy_reminder) { PerformStrategyReminder.new }

    it { expect(perform_strategy_reminder.name).to eq strategy_name }
  end
end
