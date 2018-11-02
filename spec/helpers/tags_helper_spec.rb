# frozen_string_literal: true

describe TagsHelper, type: :controller do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  controller(ApplicationController) do
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
end
