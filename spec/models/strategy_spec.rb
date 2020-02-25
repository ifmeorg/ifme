# frozen_string_literal: true
# == Schema Information
#
# Table name: strategies
#
#  id           :bigint           not null, primary key
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
  it { is_expected.to respond_to :friendly_id }

  context 'when including modules' do
    it { expect(described_class).to include Viewer }
    it { expect(described_class).to include CommonMethods }
  end

  context 'with serialize' do
    it { is_expected.to serialize(:category) }
    it { is_expected.to serialize(:viewers) }
  end

  context 'with relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_one :perform_strategy_reminder }
  end

  context 'with nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:perform_strategy_reminder) }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

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

  describe '#viewers_array_data' do
    specify do
      strategy.viewers_array_data
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

  describe '.populate_strategies_categories' do
    let(:user) { create(:user) }
    let(:user_two) { create(:user) }

    let(:category) { create(:category, user: user) }
    let(:category_two) { create(:category, user: user) }
    let(:category_three) { create(:category, user: user_two) }

    let!(:strategy) { create(:strategy, user: user, category: [category.id]) }
    let!(:strategy_two) {
      create(:strategy, user: user, category: [category.id, category_two.id]) }
    let!(:strategy_three) {
      create(:strategy, user: user_two, category: [category_three.id]) }
    let!(:strategy_four) { create(:strategy, user: user_two) }

    it 'creates join table records' do
      # Must delete join table records because they're automatically saved
      ActiveRecord::Base.connection.execute("DELETE from strategies_categories")
      expect(strategy.categories.count).to eq(0)
      expect(strategy_two.categories.count).to eq(0)
      expect(strategy_three.categories.count).to eq(0)
      expect(strategy_four.categories.count).to eq(0)

      Strategy.populate_strategies_categories

      expect(strategy.categories.count).to eq(1)
      expect(strategy.categories).to include category

      expect(strategy_two.categories.count).to eq(2)
      expect(strategy_two.categories).to include category
      expect(strategy_two.categories).to include category_two

      expect(strategy_three.categories.count).to eq(1)
      expect(strategy_three.categories).to include category_three

      expect(strategy_four.categories.count).to eq(0)
    end
  end

  describe '#category_array_data' do
    let!(:strategy) { create(:strategy) }
    let!(:category) { create(:category, user: strategy.user) }

    context 'saving categories as IDs' do
      it 'sets categories on field upon save' do
        expect(strategy.category).to eq([])
        strategy.category = [category.id.to_s]
        expect {
          strategy.save
        }.to change{ strategy.category }.to([category.id])
      end
    end

    context 'saving categories via relation' do
      let!(:category_two) { create(:category, user: strategy.user) }

      it 'creates relations between strategy and category models' do
        expect(strategy.categories.count).to eq(0)
        strategy.category = [category.id.to_s, category_two.id.to_s]
        strategy.save

        expect(strategy.categories.count).to eq(2)
        expect(strategy.categories).to include(category)
        expect(strategy.categories).to include(category_two)
      end

      it 'removes old categories when updating' do
        strategy.category = [category.id.to_s]
        strategy.save
        expect(strategy.categories).to eq [category]

        strategy.category = [category_two.id.to_s]
        strategy.save
        expect(strategy.categories).to eq [category_two]
      end
    end
  end
end
