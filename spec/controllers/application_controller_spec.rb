# frozen_string_literal: true

require_relative './shared_examples'

include ActionView::Helpers::DateHelper
include ActionView::Helpers::TextHelper

describe ApplicationController do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  describe '#most_focus' do
    it_behaves_like :most_focus, :category
    it_behaves_like :most_focus, :mood
    it_behaves_like :most_focus, :strategy
  end

  describe 'tag_usage' do
    it 'is looking for categories tagged nowhere' do
      new_category = create(:category, user_id: user1.id)
      result = controller.tag_usage(new_category.id, 'category', user1.id)
      expect(result[0].length + result[1].length).to eq(0)
    end

    it 'is looking for categories tagged in moments and strategies' do
      new_category = create(:category, user_id: user1.id)
      new_moment = create(:moment, user_id: user1.id, category: Array.new(1, new_category.id))
      new_strategy = create(:strategy, user_id: user1.id, category: Array.new(1, new_category.id))
      result = controller.tag_usage(new_category.id, 'category', user1.id)
      expect(result[0].length + result[1].length).to eq(2)
    end

    it 'is looking for moods tagged nowhere' do
      new_mood = create(:mood, user_id: user1.id)
      result = controller.tag_usage(new_mood.id, 'mood', user1.id)
      expect(result.length).to eq(0)
    end

    it 'is looking for moods tagged in moments' do
      new_mood = create(:mood, user_id: user1.id)
      new_moment = create(:moment, user_id: user1.id, mood: Array.new(1, new_mood.id))
      result = controller.tag_usage(new_mood.id, 'mood', user1.id)
      expect(result.length).to eq(1)
    end

    it 'is looking for strategies tagged nowhere' do
      new_strategy = create(:strategy, user_id: user1.id)
      result = controller.tag_usage(new_strategy.id, 'strategy', user1.id)
      expect(result.length).to eq(0)
    end

    it 'is looking for strategies tagged in moments' do
      new_strategy = create(:strategy, user_id: user1.id)
      new_moment = create(:moment, user_id: user1.id, strategy: Array.new(1, new_strategy.id))
      result = controller.tag_usage(new_strategy.id, 'strategy', user1.id)
      expect(result.length).to eq(1)
    end
  end

  describe '#get_stories' do
    let(:user_id) { user1.id }
    let(:moment) { create(:moment, user_id: user_id) }
    let(:strategy) { create(:strategy, user_id: user_id) }

    before { sign_in user1 }

    context 'when not including allies' do
      subject { controller.get_stories(user1, false) }

      context 'when there are no stories' do
        it { is_expected.to be_empty }
      end

      context 'when there is a moment' do
        before { moment }
        it { is_expected.to eq([moment]) }
      end

      context 'when there is a strategy' do
        before { strategy }
        it { is_expected.to eq([strategy]) }
      end

      context 'when there are moments and strategies' do
        before { moment; strategy }
        it { is_expected.to include(moment, strategy) }
      end
    end

    context 'when including allies' do
      let(:ally_id) { user2.id }
      let!(:allyship) { create(:allyships_accepted, user_id: user_id, ally_id: ally_id) }
      let(:viewers) { [user_id] }
      let(:timestamp) { Time.now }
      let(:ally_moment) do
        create(:moment, user_id: ally_id, viewers: viewers, published_at: timestamp)
      end
      let(:ally_strategy) do
        create(:strategy, user_id: ally_id, viewers: viewers, published_at: timestamp)
      end

      subject { controller.get_stories(user1, true) }

      context 'when there are no stories' do
        it { is_expected.to be_empty }
      end

      context 'when there are stories' do
        before do
          moment
          strategy
          ally_moment
          ally_strategy
        end

        context 'when ally stories are published' do
          it { is_expected.to include(moment, strategy, ally_moment, ally_strategy) }
        end

        context 'when ally stories are drafts' do
          let(:timestamp) { nil }
          it { is_expected.to include(moment, strategy) }
          it { is_expected.not_to include(ally_moment, ally_strategy) }
        end

        context 'when ally stories do not include user in viewers' do
          let(:viewers) { nil }
          it { is_expected.to include(moment, strategy) }
          it { is_expected.not_to include(ally_moment, ally_strategy) }
        end
      end
    end
  end
end
