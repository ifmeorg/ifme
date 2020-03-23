# frozen_string_literal: true

describe TagsHelper do
  let(:user1) { create(:user1) }

  before { allow_to_receive(:current_user, user1) }

  describe 'setup_stories' do
    it 'is looking for categories tagged nowhere' do
      @category = create(:category, user_id: user1.id)
      setup_stories
      expect(@moments.length).to eq(@total_moments)
      expect(@strategies.length).to eq(@total_strategies)
    end

    it 'is looking for categories tagged in moments and strategies' do
      @category = create(:category, user_id: user1.id)
      create(:moment, user_id: user1.id, category: Array.new(1, @category.id))
      create(:strategy, user_id: user1.id, category: Array.new(1, @category.id))
      setup_stories
      expect(@moments.length).to eq(@total_moments)
      expect(@strategies.length).to eq(@total_strategies)
    end

    it 'is looking for moods tagged nowhere' do
      @mood = create(:mood, user_id: user1.id)
      result = setup_stories
      expect(@moments.length).to eq(0)
      expect(@strategies).to eq(nil)
    end

    it 'is looking for moods tagged in moments' do
      @mood = create(:mood, user_id: user1.id)
      create(:moment, user_id: user1.id, mood: Array.new(1, @mood.id))
      setup_stories
      expect(@moments.length).to eq(@total_moments)
      expect(@strategies).to eq(nil)
    end

    it 'is looking for strategies tagged nowhere' do
      @strategy = create(:strategy, user_id: user1.id)
      setup_stories
      expect(@moments.length).to eq(@total_moments)
      expect(@strategies).to eq(nil)
    end

    it 'is looking for strategies tagged in moments' do
      @strategy = create(:strategy, user_id: user1.id)
      create(:moment, user_id: user1.id, strategy: Array.new(1, @strategy.id))
      setup_stories
      expect(@moments.length).to eq(@total_moments)
      expect(@strategies).to eq(nil)
    end
  end

  private

  def allow_to_receive(method, result)
    allow_any_instance_of(TagsHelper).to receive(method).and_return(result)
  end
end
