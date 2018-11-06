# frozen_string_literal: true
# == Schema Information
#
# Table name: strategies
#
#  id           :bigint(8)        not null, primary key
#  user_id      :integer
#  category     :text
#  description  :text
#  viewers      :text
#  comment      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  name         :string
#  slug         :string
#  published_at :datetime
#

describe Strategy do
  let(:category) { [1] }
  let(:viewers) { [1] }
  let(:strategy) { build(:strategy, category: category, viewers: viewers) }

  describe 'validation' do
    specify { expect(strategy).to be_valid }

    context 'without a user_id' do
      let(:strategy) do
        build(:strategy, user_id: nil, category: category, viewers: viewers)
      end

      specify { expect(strategy).to be_invalid }
    end
  end

  describe '#array_data_to_i!' do
    specify do
      strategy.array_data_to_i!
      expect(strategy.category).to eq([1])
      expect(strategy.viewers).to eq([1])
    end
  end

  describe '#active_reminders' do
    subject { strategy.active_reminders }

    describe 'when strategy has no reminders' do
      let(:strategy) { create(:strategy) }

      specify { expect(subject).to eq([]) }
    end

    describe 'when strategy has daily reminder' do
      let(:strategy) { create(:strategy, :with_daily_reminder) }

      it 'is a list containing the daily reminder' do
        expect(subject).to eq([strategy.perform_strategy_reminder])
      end
    end
  end

  describe '#published?' do
    context 'when it has a publication date' do
      let(:strategy) { build(:strategy, :with_published_at) }
      let(:subject) { strategy.published? }

      it { is_expected.to be true }
    end
    context 'when it does not have a publication date' do
      let(:strategy) { create(:strategy) }
      let(:subject) { strategy.published? }
      it { is_expected.to be false }
    end
  end
end
