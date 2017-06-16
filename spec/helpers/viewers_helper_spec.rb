describe ViewersHelper do
  describe '#number_of_viewers' do
    let(:owner_id) { 1 }

    let!(:viewers) do
      users = viewer_count.times.map do |i|
        create :user1, name: "Viewer #{i}"
      end
      users.map(&:id)
    end
    subject { number_of_viewers(current_user_id, owner_id, viewers) }

    context 'when current_user_is_owner is true' do
      let(:current_user_id) { 1 }

      context 'and when number of viewers is 0' do
        let(:viewer_count) { 0 }

        it 'says there are no viewers' do
          expect(subject).to eq 'There are <strong>no</strong> viewers.'
        end
      end

      context 'and when number of viewers is 1' do
        let(:viewer_count) { 1 }

        it 'lists the one viewer' do
          expect(subject).to eq 'Viewer 0 is a viewer.'
        end
      end

      context 'and when number of viewers is 2' do
        let(:viewer_count) { 2 }

        it "lists the two viewers' names" do
          expect(subject).to eq 'Viewer 0 and Viewer 1 are viewers.'
        end
      end

      context 'and when number of viewers is more than 2' do
        let(:viewer_count) { 3 }

        it "lists all the viewers' names" do
          expect(subject).to eq 'Viewer 0, Viewer 1, and Viewer 2 are viewers.'
        end
      end
    end

    context 'when current_user_is_owner is false' do
      let(:current_user_id) { 6 }

      context 'and when viewer is the only viewer' do
        let(:viewer_count) { 1 }

        it 'says you are the only viewer' do
          expect(subject).to eq 'You are the only viewer.'
        end
      end

      context 'and when viewer is not the only viewer' do
        let(:viewer_count) { 2 }

        it 'says you are not the only viewer' do
          expect(subject).to eq 'You are <strong>not</strong> the only viewer.'
        end
      end
    end
  end

  describe "viewers_hover" do
    it "displays only you when there are no viewers without link" do
      result = viewers_hover(nil, nil)
      expect(result).to eq('<span class="yes_title small_margin_right" title="Only you"><i class="fa fa-lock"></i></span>')
    end

    it "displays only you when there are no viewers with link" do
      new_user1 = create(:user1)
      new_category = create(:category, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id))
      result = viewers_hover(nil, new_category)
      expect(result).to eq('<span class="yes_title" title="Visible to only you"><a href="/categories/test-category">Test Category</a></span>')
    end

    it "displays list of viewers without link" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      result = viewers_hover([new_user1.id, new_user2.id, new_user3.id], nil)
      expect(result).to eq('<span class="yes_title small_margin_right" title="Oprah Chang, Plum Blossom, and Gentle Breezy"><i class="fa fa-lock"></i></span>')
    end

    it "displays list of viewers with link" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      viewers = [new_user1.id, new_user2.id, new_user3.id]
      new_category = create(:category, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: viewers)
      result = viewers_hover(viewers, new_category)
      expect(result).to eq('<span class="yes_title" title="Visible to Oprah Chang, Plum Blossom, and Gentle Breezy"><a href="/categories/test-category">Test Category</a></span>')
    end
  end

  describe "get_viewers_for" do
    it "returns empty array for invalid input" do
      result = get_viewers_for(nil, nil)
      expect(result.length).to eq(0)
    end

    it "returns array of size 1 for valid input of data type category" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_category = create(:category, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
      new_strategy = create(:strategy, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_category, 'category')
      expect(result.length).to eq(1)
      expect(result[0]).to eq(new_user2.id)
    end

    it "returns array of size 2 for valid input of data type category" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      new_category = create(:category, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: [new_user2.id, new_user3.id])
      new_strategy = create(:strategy, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_category, 'category')
      expect(result.length).to eq(2)
      expect(result[0]).to eq(new_user2.id)
      expect(result[1]).to eq(new_user3.id)
    end

    it "returns array of size 1 for valid input of data type mood" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_mood = create(:mood, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, mood: Array.new(1, new_mood.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_mood, 'mood')
      expect(result.length).to eq(1)
      expect(result[0]).to eq(new_user2.id)
    end

    it "returns array of size 2 for valid input of data type mood" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      new_mood = create(:mood, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, mood: Array.new(1, new_mood.id), viewers: [new_user2.id, new_user3.id])
      result = get_viewers_for(new_mood, 'mood')
      expect(result.length).to eq(2)
      expect(result[0]).to eq(new_user2.id)
      expect(result[1]).to eq(new_user3.id)
    end

    it "returns array of size 1 for valid input of data type strategy" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_strategy = create(:strategy, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, strategies: Array.new(1, new_strategy.id), viewers: Array.new(1, new_user2.id))
      result = get_viewers_for(new_strategy, 'strategy')
      expect(result.length).to eq(1)
      expect(result[0]).to eq(new_user2.id)
    end

    it "returns array of size 2 for valid input of data type strategy" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_user3 = create(:user3)
      new_strategy = create(:strategy, userid: new_user1.id)
      new_moment = create(:moment, userid: new_user1.id, strategies: Array.new(1, new_strategy.id), viewers: [new_user2.id, new_user3.id])
      result = get_viewers_for(new_strategy, 'strategy')
      expect(result.length).to eq(2)
      expect(result[0]).to eq(new_user2.id)
      expect(result[1]).to eq(new_user3.id)
    end
  end
end
