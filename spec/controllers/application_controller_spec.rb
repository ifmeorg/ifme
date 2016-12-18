include ActionView::Helpers::DateHelper
include ActionView::Helpers::TextHelper
include LocalTimeHelper

describe ApplicationController do
  describe "most_focus" do
    describe "categories" do
      it "returns an empty hash because no categories exist" do
        new_user = create(:user1)
        sign_in new_user
        new_moment = create(:moment, userid: new_user.id)
        new_strategy = create(:strategy, userid: new_user.id)
        expect(controller.most_focus('category', nil).length).to eq(0)
      end

      describe "returns a hash because categories exist" do
        it "returns a hash of size 1 when the same category is used twice" do
          new_user = create(:user1)
          sign_in new_user
          new_category = create(:category, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id))
          new_strategy = create(:strategy, userid: new_user.id, category: Array.new(1, new_category.id))
          result = controller.most_focus('category', nil)
          expect(result.length).to eq(1)
          expect(result[new_category.id]).to eq(2)
        end

        it "returns a hash of size 2" do
          new_user = create(:user1)
          sign_in new_user
          new_category1 = create(:category, userid: new_user.id)
          new_category2 = create(:category, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category1.id))
          new_strategy = create(:strategy, userid: new_user.id, category: Array.new(1, new_category2.id))
          result = controller.most_focus('category', nil)
          expect(result.length).to eq(2)
          expect(result[new_category1.id]).to eq(1)
          expect(result[new_category2.id]).to eq(1)
        end

        it "returns a correct hash of size 3" do
          new_user = create(:user1)
          sign_in new_user
          new_category1 = create(:category, userid: new_user.id)
          new_category2 = create(:category, userid: new_user.id)
          new_category3 = create(:category, userid: new_user.id)
          new_category4 = create(:category, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category2.id))
          new_strategy = create(:strategy, userid: new_user.id, category: [new_category1.id, new_category2.id, new_category3.id, new_category4.id])
          result = controller.most_focus('category', nil)
          expect(result.length).to eq(3)
          expect(result[new_category1.id]).to eq(1)
          expect(result[new_category2.id]).to eq(2)
          expect(result[new_category3.id]).to eq(1)
          expect(result[new_category4.id]).to eq(nil)
        end

        it "returns a correct hash of size 1 belonging to another user" do
          new_user1 = create(:user1)
          new_user2 = create(:user2)
          sign_in new_user1
          new_category1 = create(:category, userid: new_user2.id)
          new_category2 = create(:category, userid: new_user2.id)
          new_category3 = create(:category, userid: new_user2.id)
          new_category4 = create(:category, userid: new_user2.id)
          new_moment = create(:moment, userid: new_user2.id, category: Array.new(1, new_category2.id), viewers: Array.new(1, new_user1.id))
          new_strategy = create(:strategy, userid: new_user2.id, category: [new_category1.id, new_category2.id, new_category3.id, new_category4.id])
          result = controller.most_focus('category', new_user2.id)
          expect(result.length).to eq(1)
          expect(result[new_category1.id]).to eq(nil)
          expect(result[new_category2.id]).to eq(1)
          expect(result[new_category3.id]).to eq(nil)
          expect(result[new_category4.id]).to eq(nil)
        end
      end
    end

    describe "moods" do
      it "returns an empty hash because no moods exist" do
        new_user = create(:user1)
        sign_in new_user
        new_moment = create(:moment, userid: new_user.id)
        expect(controller.most_focus('mood', nil).length).to eq(0)
      end

      describe "returns a hash because moods exist" do
        it "returns a hash of size 1 when the same mood is used twice" do
          new_user = create(:user1)
          sign_in new_user
          new_mood = create(:mood, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, mood: Array.new(1, new_mood.id))
          result = controller.most_focus('mood', nil)
          expect(result.length).to eq(1)
          expect(result[new_mood.id]).to eq(1)
        end

        it "returns a hash of size 2" do
          new_user = create(:user1)
          sign_in new_user
          new_mood1 = create(:mood, userid: new_user.id)
          new_mood2 = create(:mood, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, mood: [new_mood1.id, new_mood2.id])
          result = controller.most_focus('mood', nil)
          expect(result.length).to eq(2)
          expect(result[new_mood1.id]).to eq(1)
          expect(result[new_mood2.id]).to eq(1)
        end

        it "returns a correct hash of size 3" do
          new_user = create(:user1)
          sign_in new_user
          new_mood1 = create(:mood, userid: new_user.id)
          new_mood2 = create(:mood, userid: new_user.id)
          new_mood3 = create(:mood, userid: new_user.id)
          new_mood4 = create(:mood, userid: new_user.id)
          new_moment1 = create(:moment, userid: new_user.id, mood: Array.new(1, new_mood2.id))
          new_moment2 = create(:moment, userid: new_user.id, mood: [new_mood1.id, new_mood2.id, new_mood3.id, new_mood4.id])
          result = controller.most_focus('mood', nil)
          expect(result.length).to eq(3)
          expect(result[new_mood1.id]).to eq(1)
          expect(result[new_mood2.id]).to eq(2)
          expect(result[new_mood3.id]).to eq(1)
          expect(result[new_mood4.id]).to eq(nil)
        end

        it "returns a correct hash of size 1 belonging to another user" do
          new_user1 = create(:user1)
          new_user2 = create(:user2)
          sign_in new_user1
          new_mood1 = create(:mood, userid: new_user2.id)
          new_mood2 = create(:mood, userid: new_user2.id)
          new_mood3 = create(:mood, userid: new_user2.id)
          new_mood4 = create(:mood, userid: new_user2.id)
          new_moment1 = create(:moment, userid: new_user2.id, mood: Array.new(1, new_mood2.id), viewers: Array.new(1, new_user1.id))
          new_moment2 = create(:moment, userid: new_user2.id, mood: [new_mood1.id, new_mood2.id, new_mood3.id, new_mood4.id])
          result = controller.most_focus('mood', new_user2.id)
          expect(result.length).to eq(1)
          expect(result[new_mood1.id]).to eq(nil)
          expect(result[new_mood2.id]).to eq(1)
          expect(result[new_mood3.id]).to eq(nil)
          expect(result[new_mood4.id]).to eq(nil)
        end
      end
    end

    describe "strategy" do
      it "returns an empty hash because no strategies exist" do
        new_user = create(:user1)
        sign_in new_user
        new_moment = create(:moment, userid: new_user.id)
        expect(controller.most_focus('strategy', nil).length).to eq(0)
      end

      describe "returns a hash because strategies exist" do
        it "returns a hash of size 1 when the same strategy is used twice" do
          new_user = create(:user1)
          sign_in new_user
          new_strategy = create(:strategy, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, strategies: Array.new(1, new_strategy.id))
          result = controller.most_focus('strategy', nil)
          expect(result.length).to eq(1)
          expect(result[new_strategy.id]).to eq(1)
        end

        it "returns a hash of size 2" do
          new_user = create(:user1)
          sign_in new_user
          new_strategy1 = create(:strategy, userid: new_user.id)
          new_strategy2 = create(:strategy, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, strategies: [new_strategy1.id, new_strategy2.id])
          result = controller.most_focus('strategy', nil)
          expect(result.length).to eq(2)
          expect(result[new_strategy1.id]).to eq(1)
          expect(result[new_strategy2.id]).to eq(1)
        end

        it "returns a correct hash of size 3" do
          new_user = create(:user1)
          sign_in new_user
          new_strategy1 = create(:strategy, userid: new_user.id)
          new_strategy2 = create(:strategy, userid: new_user.id)
          new_strategy3 = create(:strategy, userid: new_user.id)
          new_strategy4 = create(:strategy, userid: new_user.id)
          new_moment1 = create(:moment, userid: new_user.id, strategies: Array.new(1, new_strategy2.id))
          new_moment2 = create(:moment, userid: new_user.id, strategies: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id])
          result = controller.most_focus('strategy', nil)
          expect(result.length).to eq(3)
          expect(result[new_strategy1.id]).to eq(1)
          expect(result[new_strategy2.id]).to eq(2)
          expect(result[new_strategy3.id]).to eq(1)
          expect(result[new_strategy4.id]).to eq(nil)
        end

        it "returns a correct hash of size 1 belonging to another user" do
          new_user1 = create(:user1)
          new_user2 = create(:user2)
          sign_in new_user1
          new_strategy1 = create(:strategy, userid: new_user2.id)
          new_strategy2 = create(:strategy, userid: new_user2.id)
          new_strategy3 = create(:strategy, userid: new_user2.id)
          new_strategy4 = create(:strategy, userid: new_user2.id)
          new_moment1 = create(:moment, userid: new_user2.id, strategies: Array.new(1, new_strategy2.id), viewers: Array.new(1, new_user1.id))
          new_moment2 = create(:moment, userid: new_user2.id, strategies: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id])
          result = controller.most_focus('strategy', new_user2.id)
          expect(result.length).to eq(1)
          expect(result[new_strategy1.id]).to eq(nil)
          expect(result[new_strategy2.id]).to eq(1)
          expect(result[new_strategy3.id]).to eq(nil)
          expect(result[new_strategy4.id]).to eq(nil)
        end
      end
    end
  end

  describe "tag_usage" do
    it "is looking for categories tagged nowhere" do
      new_user = create(:user1)
      new_category = create(:category, userid: new_user.id)
      result = controller.tag_usage(new_category.id, 'category', new_user.id)
        expect(result[0].length + result[1].length).to eq(0)
    end

    it "is looking for categories tagged in moments and strategies" do
      new_user = create(:user1)
      new_category = create(:category, userid: new_user.id)
        new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id))
        new_strategy = create(:strategy, userid: new_user.id, category: Array.new(1, new_category.id))
        result = controller.tag_usage(new_category.id, 'category', new_user.id)
        expect(result[0].length + result[1].length).to eq(2)
    end

    it "is looking for moods tagged nowhere" do
      new_user = create(:user1)
      new_mood = create(:mood, userid: new_user.id)
      result = controller.tag_usage(new_mood.id, 'mood', new_user.id)
        expect(result.length).to eq(0)
    end

    it "is looking for moods tagged in moments" do
      new_user = create(:user1)
      new_mood = create(:mood, userid: new_user.id)
        new_moment = create(:moment, userid: new_user.id, mood: Array.new(1, new_mood.id))
        result = controller.tag_usage(new_mood.id, 'mood', new_user.id)
        expect(result.length).to eq(1)
    end

    it "is looking for strategies tagged nowhere" do
      new_user = create(:user1)
      new_strategy = create(:strategy, userid: new_user.id)
      result = controller.tag_usage(new_strategy.id, 'strategy', new_user.id)
        expect(result.length).to eq(0)
    end

    it "is looking for strategies tagged in moments" do
      new_user = create(:user1)
      new_strategy = create(:strategy, userid: new_user.id)
        new_moment = create(:moment, userid: new_user.id, strategies: Array.new(1, new_strategy.id))
        result = controller.tag_usage(new_strategy.id, 'strategy', new_user.id)
        expect(result.length).to eq(1)
    end
  end

  describe "get_stories" do
    it "has no stories and does not include allies" do
      new_user = create(:user1)
      sign_in new_user
        expect(controller.get_stories(new_user, false).length).to eq(0)
    end

    it "has only moments and does not include allies" do
      new_user = create(:user1)
      sign_in new_user
      new_moment = create(:moment, userid: new_user.id)
      expect(controller.get_stories(new_user, false).length).to eq(1)
    end

    it "has only strategies and does not include allies" do
      new_user = create(:user1)
      sign_in new_user
      new_strategy = create(:strategy, userid: new_user.id)
      expect(controller.get_stories(new_user, false).length).to eq(1)
    end

    it "has both moments and strategies, and does not include allies" do
      new_user = create(:user1)
      sign_in new_user
      new_moment = create(:moment, userid: new_user.id)
      new_strategy = create(:strategy, userid: new_user.id)
      expect(controller.get_stories(new_user, false).length).to eq(2)

    end

    it "has no stories and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
        expect(controller.get_stories(new_user1, true).length).to eq(0)
    end

    it "has only moments and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user1.id)
      new_moment2 = create(:moment, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user1, true).length).to eq(2)
    end

    it "has only strategies and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_strategy1 = create(:strategy, userid: new_user1.id)
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user1, true).length).to eq(2)
    end

    it "has both moments and strategies, and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user1.id)
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user1, true).length).to eq(2)

    end

    it "has no moments and strategies despite being allies with user" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user2.id)
      new_strategy2 = create(:strategy, userid: new_user2.id)
      expect(controller.get_stories(new_user2, false).length).to eq(0)
    end

    it "has both moments and strategies and is allies with user" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user2.id, viewers: [new_user1.id])
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user2, false).length).to eq(2)
    end
  end

  describe "moments_stats" do
    it "has no moments" do
      new_user = create(:user1)
      sign_in new_user
        expect(controller.moments_stats).to eq('')
    end

    it "has one moment" do
      new_user = create(:user1)
      sign_in new_user
      new_moment = create(:moment, userid: new_user.id)
      expect(controller.moments_stats).to eq('')
    end

    it "has more than one moment created this month" do
      new_user = create(:user1)
      sign_in new_user
      new_moment1 = create(:moment, userid: new_user.id)
      new_moment2 = create(:moment, userid: new_user.id)
      expect(controller.moments_stats).to eq('<div class="center" id="stats">You have written a <strong>total</strong> of <strong>2</strong> moments.</div>')
    end

    it "has more than one moment created on different months" do
      new_user = create(:user1)
      sign_in new_user
      new_moment1 = create(:moment, userid: new_user.id, created_at: '2014-01-01 00:00:00')
      new_moment2 = create(:moment, userid: new_user.id)

      expect(controller.moments_stats).to eq('<div class="center" id="stats">You have written a <strong>total</strong> of <strong>2</strong> moments. This <strong>month</strong> you wrote <strong>1</strong> moment.</div>')

      new_moment3 = create(:moment, userid: new_user.id)

      expect(controller.moments_stats).to eq('<div class="center" id="stats">You have written a <strong>total</strong> of <strong>3</strong> moments. This <strong>month</strong> you wrote <strong>2</strong> moments.</div>')
    end
  end

  describe "created_or_edited" do
    it "returns created_at if updated_at does not exist" do
      new_user1 = create(:user1)
      new_moment = create(:moment, userid: new_user1.id)
      result = controller.created_or_edited(new_moment)
      expect(result).to eq("<strong>Created:</strong> #{local_time_ago(new_moment.created_at)}")
    end

    it "returns created_at with (edited) if local_time_ago formatting of updated_at is equal to created_at" do
      new_user1 = create(:user1)
      new_moment = create(:moment, userid: new_user1.id)
      new_category = create(:category, userid: new_user1.id)
      new_moment.update(category: Array.new(1, new_category.id))
      result = controller.created_or_edited(new_moment)
      expect(result).to eq("<strong>Created:</strong> #{local_time_ago(new_moment.created_at)} <em>(edited)</em>")
    end

    it "returns created_at with updated_at if local_time_ago formatting of updated_at is not equal to created_at" do
      new_user1 = create(:user1)
      new_moment = create(:moment, userid: new_user1.id, created_at: '2014-01-01 00:00:00')
      new_category = create(:category, userid: new_user1.id)
      new_moment.update(category: Array.new(1, new_category.id))
      result = controller.created_or_edited(new_moment)
      expect(result).to eq("<strong>Created:</strong> #{local_time_ago(new_moment.created_at)} <em>(edited #{local_time_ago(new_moment.updated_at)})</em>")
    end
  end

  describe '#visibility_html' do
    let(:owner) { FactoryGirl.create(:user2, :with_allies) }
    let(:ally) { owner.allies.first }
    let(:ally_commenter) { owner.allies.second }

    let(:strategy) { FactoryGirl.create(:strategy, userid: owner.id) }
    let(:moment) { FactoryGirl.create(:moment, userid: owner.id) }

    let(:commentable) {
      {
        strategy: strategy,
        moment: moment
      }
    }

    [:strategy, :moment].each do |commentable_name|
      let(:commented_on) { commentable[commentable_name] }

      let(:comment) { Comment.create!(:comment_type => commentable_name,
                                      :commented_on => commented_on.id,
                                      :comment_by => commenter.id,
                                      :comment => 'test comment',
                                      :visibility => visibility,
                                      :viewers => viewers) }

      let(:visibility_html) { controller.send(:visibility_html, comment, commented_on) }

      describe 'private comments (visible to you and 1 ally)' do
        let(:visibility) { 'private' }

        describe 'and comment was made by owner' do
          let(:commenter) { owner }
          let(:viewers) { [ally.id] }

          describe 'logged in as owner' do

            before do
              sign_in owner
            end

            it "has the ally's name in visibility" do
              expect(visibility_html).to eq("<div class=\"subtle\">Visible only between you and #{ally.name}</div>")
            end
          end

          describe 'logged in as ally' do
            before do
              sign_in ally
            end

            it "has the owner's name in visibility" do
              expect(visibility_html).to eq("<div class=\"subtle\">Visible only between you and #{owner.name}</div>")
            end
          end
        end

        describe 'and comment was made by an ally' do
          let(:commenter) { ally_commenter }
          let(:viewers) { [ ] }

          describe 'logged in as owner' do
            before do
              sign_in owner
            end

            it "has the ally's name in visibility" do
              expect(visibility_html).to eq("<div class=\"subtle\">Visible only between you and #{ally_commenter.name}</div>")
            end
          end

          describe 'logged in as commenter' do
            before do
              sign_in ally_commenter
            end

            it "has the owner's name in visibility" do
              expect(visibility_html).to eq("<div class=\"subtle\">Visible only between you and #{owner.name}</div>")
            end
          end
        end
      end

      describe 'public comments (visible to all allies)' do
        let(:visibility) { 'all' }
        let(:viewers) { [] }

        describe 'and comment was made by owner' do
          let(:commenter) { owner }

          describe 'logged in as owner' do
            before do
              sign_in owner
            end

            it 'has nothing for visibility' do
              expect(visibility_html).to be_nil
            end
          end

          describe 'logged in as ally' do
            before do
              sign_in ally
            end

            it 'has nothing for visibility' do
              expect(visibility_html).to be_nil
            end
          end
        end

        describe 'and comment was made by ally' do
          let(:commenter) { ally_commenter }

          describe 'logged in as owner' do
            before do
              sign_in owner
            end

            it 'has nothing for visibility' do
              expect(visibility_html).to be_nil
            end
          end

          describe 'logged in as commenter' do
            before do
              sign_in commenter
            end

            it 'has nothing for visibility' do
              expect(visibility_html).to be_nil
            end
          end
        end
      end
    end
  end
end
