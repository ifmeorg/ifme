# frozen_string_literal: true
# == Schema Information
#
# Table name: strategies
#
#  id           :bigint           not null, primary key
#  user_id      :integer
#  description  :text
#  viewers      :text
#  comment      :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  name         :string
#  slug         :string
#  published_at :datetime
#  visible      :boolean          default(TRUE)
#  bookmarked   :boolean          default(FALSE)
#

describe Strategy do
  it { is_expected.to respond_to :friendly_id }

  context 'when including modules' do
    it { expect(described_class).to include Viewer }
    it { expect(described_class).to include CommonMethods }
  end

  context 'with serialize' do
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

  describe '#category_array_data' do
    let!(:strategy) { create(:strategy) }
    let!(:category) { create(:category, user: strategy.user) }

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
