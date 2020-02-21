# frozen_string_literal: true

describe ViewersHelper do
  describe 'viewers_hover' do
    let(:element) { '<a href="/categories/test-category">Test Category</a>' }
    before(:each) do
      allow(self).to receive(:react_component).and_return(nil)
    end

    it 'displays only you when there are no viewers with link' do
      new_user1 = create(:user1)
      new_category = create(:category, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, category: Array.new(1, new_category.id))
      expect(self).to receive(:react_component).with(
        'Tooltip',
        props: {
          element: element,
          text: 'Visible to only you',
          center: true
        }
      )
      viewers_hover(nil, new_category)
    end

    it 'displays list of viewers with link' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      viewers = [new_user1.id, new_user2.id, new_user3.id]
      new_category = create(:category, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, category: Array.new(1, new_category.id), viewers: viewers)
      expect(self).to receive(:react_component).with(
        'Tooltip',
        props: {
          element: element,
          text: 'Visible to Oprah Chang, Plum Blossom, and Gentle Breezy',
          center: true
        }
      )
      viewers_hover(viewers, new_category)
    end
  end

  describe 'get_viewers_for' do
    it 'returns empty array for invalid input' do
      result = get_viewers_for(nil, nil)
      expect(result.length).to eq(0)
    end

    it 'returns array of size 1 for valid input of data type category' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_category = create(:category, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
      new_strategy = create(:strategy, user_id: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_category, 'category')
      expect(result.length).to eq(1)
      expect(result[0]).to eq(new_user2.id)
    end

    it 'returns array of size 2 for valid input of data type category' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      new_category = create(:category, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, category: Array.new(1, new_category.id), viewers: [new_user2.id, new_user3.id])
      new_strategy = create(:strategy, user_id: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_category, 'category')
      expect(result.length).to eq(2)
      expect(result[0]).to eq(new_user2.id)
      expect(result[1]).to eq(new_user3.id)
    end

    it 'returns array of size 1 for valid input of data type mood' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_mood = create(:mood, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, mood: Array.new(1, new_mood.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_mood, 'moods')
      expect(result.length).to eq(1)
      expect(result[0]).to eq(new_user2.id)
    end

    it 'returns array of size 2 for valid input of data type mood' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      new_mood = create(:mood, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, mood: Array.new(1, new_mood.id), viewers: [new_user2.id, new_user3.id])
      result = get_viewers_for(new_mood, 'moods')
      expect(result.length).to eq(2)
      expect(result[0]).to eq(new_user2.id)
      expect(result[1]).to eq(new_user3.id)
    end

    it 'returns array of size 1 for valid input of data type strategy' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_strategy = create(:strategy, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, strategy: Array.new(1, new_strategy.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_strategy, 'strategy')
      expect(result.length).to eq(1)
      expect(result[0]).to eq(new_user2.id)
    end

    it 'returns array of size 2 for valid input of data type strategy' do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      new_strategy = create(:strategy, user_id: new_user1.id)
      new_moment = create(:moment, user_id: new_user1.id, strategy: Array.new(1, new_strategy.id), viewers: [new_user2.id, new_user3.id])
      result = get_viewers_for(new_strategy, 'strategy')
      expect(result.length).to eq(2)
      expect(result[0]).to eq(new_user2.id)
      expect(result[1]).to eq(new_user3.id)
    end
  end
end
