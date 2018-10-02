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

  describe 'moments_stats' do
    before(:example) do
      sign_in user1
    end
    it 'has no moments' do
      expect(controller.moments_stats).to eq('')
    end

    it 'has one moment' do
      new_moment = create(:moment, user_id: user1.id)
      expect(controller.moments_stats).to eq('')
    end

    it 'has more than one moment created this month' do
      new_moment1 = create(:moment, user_id: user1.id)
      new_moment2 = create(:moment, user_id: user1.id)
      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>2</strong> moments.</div>')
    end

    it 'has more than one moment created on different months' do
      new_moment1 = create(:moment, user_id: user1.id, created_at: '2014-01-01 00:00:00')
      new_moment2 = create(:moment, user_id: user1.id)

      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>2</strong> moments. This <strong>month</strong> you wrote <strong>1</strong> moment.</div>')

      new_moment3 = create(:moment, user_id: user1.id)

      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>3</strong> moments. This <strong>month</strong> you wrote <strong>2</strong> moments.</div>')
    end
  end
end
