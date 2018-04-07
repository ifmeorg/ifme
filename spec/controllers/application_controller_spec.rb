include ActionView::Helpers::DateHelper
include ActionView::Helpers::TextHelper

AVATAR_COMPONENT_NAME = 'Avatar';

RSpec::Matchers.define :be_avatar_component do
  match do
    have_tag('script', with: { 'data-component-name': AVATAR_COMPONENT_NAME })
  end
end

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
          result = controller.most_focus('category', new_user.id)
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
          result = controller.most_focus('category', new_user.id)
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
          result = controller.most_focus('category', new_user.id)
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
          new_moment = create(:moment, userid: new_user2.id, category: Array.new(1, new_category2.id), viewers: Array.new(1, new_user1.id), published_at: Time.zone.now)
          new_strategy = create(:strategy, userid: new_user2.id, category: [new_category1.id, new_category2.id, new_category3.id, new_category4.id], published_at: Time.zone.now)
          result = controller.most_focus('category', new_user2.id)
          expect(result.length).to eq(1)
          expect(result[new_category1.id]).to eq(nil)
          expect(result[new_category2.id]).to eq(1)
          expect(result[new_category3.id]).to eq(nil)
          expect(result[new_category4.id]).to eq(nil)
        end

        it "returns a correct hash of size 0 belonging to another user when his/her posts are drafts" do
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
          expect(result.length).to eq(0)
          expect(result[new_category1.id]).to eq(nil)
          expect(result[new_category2.id]).to eq(nil)
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
          result = controller.most_focus('mood', new_user.id)
          expect(result.length).to eq(1)
          expect(result[new_mood.id]).to eq(1)
        end

        it "returns a hash of size 2" do
          new_user = create(:user1)
          sign_in new_user
          new_mood1 = create(:mood, userid: new_user.id)
          new_mood2 = create(:mood, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, mood: [new_mood1.id, new_mood2.id])
          result = controller.most_focus('mood', new_user.id)
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
          result = controller.most_focus('mood', new_user.id)
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
          new_moment1 = create(:moment, userid: new_user2.id, mood: Array.new(1, new_mood2.id), viewers: Array.new(1, new_user1.id), published_at: Time.zone.now)
          new_moment2 = create(:moment, userid: new_user2.id, mood: [new_mood1.id, new_mood2.id, new_mood3.id, new_mood4.id], published_at: Time.zone.now)
          result = controller.most_focus('mood', new_user2.id)
          expect(result.length).to eq(1)
          expect(result[new_mood1.id]).to eq(nil)
          expect(result[new_mood2.id]).to eq(1)
          expect(result[new_mood3.id]).to eq(nil)
          expect(result[new_mood4.id]).to eq(nil)
        end

        it "returns a correct hash of size 0 belonging to another user when all his/her posts are drafts" do
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
          expect(result.length).to eq(0)
          expect(result[new_mood1.id]).to eq(nil)
          expect(result[new_mood2.id]).to eq(nil)
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
          new_moment = create(:moment, userid: new_user.id, strategy: Array.new(1, new_strategy.id))
          result = controller.most_focus('strategy', new_user.id)
          expect(result.length).to eq(1)
          expect(result[new_strategy.id]).to eq(1)
        end

        it "returns a hash of size 2" do
          new_user = create(:user1)
          sign_in new_user
          new_strategy1 = create(:strategy, userid: new_user.id)
          new_strategy2 = create(:strategy, userid: new_user.id)
          new_moment = create(:moment, userid: new_user.id, strategy: [new_strategy1.id, new_strategy2.id])
          result = controller.most_focus('strategy', new_user.id)
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
          new_moment1 = create(:moment, userid: new_user.id, strategy: Array.new(1, new_strategy2.id))
          new_moment2 = create(:moment, userid: new_user.id, strategy: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id])
          result = controller.most_focus('strategy', new_user.id)
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
          new_moment1 = create(:moment, userid: new_user2.id, strategy: Array.new(1, new_strategy2.id), viewers: Array.new(1, new_user1.id), published_at: Time.zone.now)
          new_moment2 = create(:moment, userid: new_user2.id, strategy: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id], published_at: Time.zone.now)
          result = controller.most_focus('strategy', new_user2.id)
          expect(result.length).to eq(1)
          expect(result[new_strategy1.id]).to eq(nil)
          expect(result[new_strategy2.id]).to eq(1)
          expect(result[new_strategy3.id]).to eq(nil)
          expect(result[new_strategy4.id]).to eq(nil)
        end

        it "returns a correct hash of size 0 belonging to another user when all his/her posts are drafts" do
          new_user1 = create(:user1)
          new_user2 = create(:user2)
          sign_in new_user1
          new_strategy1 = create(:strategy, userid: new_user2.id)
          new_strategy2 = create(:strategy, userid: new_user2.id)
          new_strategy3 = create(:strategy, userid: new_user2.id)
          new_strategy4 = create(:strategy, userid: new_user2.id)
          new_moment1 = create(:moment, userid: new_user2.id, strategy: Array.new(1, new_strategy2.id), viewers: Array.new(1, new_user1.id))
          new_moment2 = create(:moment, userid: new_user2.id, strategy: [new_strategy1.id, new_strategy2.id, new_strategy3.id, new_strategy4.id])
          result = controller.most_focus('strategy', new_user2.id)
          expect(result.length).to eq(0)
          expect(result[new_strategy1.id]).to eq(nil)
          expect(result[new_strategy2.id]).to eq(nil)
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
        new_moment = create(:moment, userid: new_user.id, strategy: Array.new(1, new_strategy.id))
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
      new_moment1 = create(:moment, userid: new_user1.id, published_at: Time.zone.now)
      new_moment2 = create(:moment, userid: new_user2.id, viewers: [new_user1.id], published_at: Time.zone.now)
      expect(controller.get_stories(new_user1, true).length).to eq(2)
    end

    it "has only other users' draft moments and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment2 = create(:moment, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user1, true).length).to eq(0)
    end

    it "has only strategies and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_strategy1 = create(:strategy, userid: new_user1.id, published_at: Time.zone.now)
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id], published_at: Time.zone.now)
      expect(controller.get_stories(new_user1, true).length).to eq(2)
    end

    it "has only other users' draft strategies and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user1, true).length).to eq(0)
    end

    it "has both moments and strategies, and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user1.id, published_at: Time.zone.now)
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id], published_at: Time.zone.now)
      expect(controller.get_stories(new_user1, true).length).to eq(2)
    end

    it "has only users' draft moments and strategies, and does include allies" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment2 = create(:moment, userid: new_user2.id)
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user1, true).length).to eq(0)
    end

    it "has no moments and strategies despite being allies with user" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment2 = create(:moment, userid: new_user2.id)
      new_strategy2 = create(:strategy, userid: new_user2.id)
      expect(controller.get_stories(new_user2, false).length).to eq(0)
    end

    it "has both moments and strategies and is allies with user" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user2.id, viewers: [new_user1.id], published_at: Time.zone.now)
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id], published_at: Time.zone.now)
      expect(controller.get_stories(new_user2, false).length).to eq(2)
    end

    it "has both moments and strategies and is allies with user, but her/his posts are all drafts" do
      new_user1 = create(:user1)
      new_user2 = create(:user2)
      new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
      sign_in new_user1
      new_moment1 = create(:moment, userid: new_user2.id, viewers: [new_user1.id])
      new_strategy2 = create(:strategy, userid: new_user2.id, viewers: [new_user1.id])
      expect(controller.get_stories(new_user2, false).length).to eq(0)
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

  describe 'generate_comment' do
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2) }
    let(:user3) { create(:user3) }
    let(:comment) { 'Hello from the outside'}

    def delete_comment(comment_id)
      %(<div class="table_cell delete_comment"><a id="delete_comment_#{comment_id}" class="delete_comment_button" href=""><i class="fa fa-times"></i></a></div>)
    end

    def comment_info(user)
      %(<a href="/profile?uid=#{controller.get_uid(user.id)}">#{user.name}</a> - less than a minute ago)
    end

    before do
      create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
      create(:allyships_accepted, user_id: user1.id, ally_id: user3.id)
    end

    context 'Moments' do
      let(:new_moment) { create(:moment, userid: user1.id, viewers: [user2.id, user3.id]) }

      context 'Comment posted by Moment creator who is logged in' do
        before(:each) do
          sign_in user1
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user1.id, visibility: 'private', viewers: [user2.id])
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: "Visible only between you and #{user2.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end

      context 'Comment posted by Moment viewer who is logged in' do
        before(:each) do
          sign_in user2
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'moment', commentable_id: new_moment.id, comment_by: user2.id, visibility: 'private', viewers: [user1.id])
          expect(controller.generate_comment(new_comment, 'moment')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: "Visible only between you and #{user1.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end
    end

    context 'Strategies' do
      let(:new_strategy) { create(:strategy, userid: user1.id, viewers: [user2.id, user3.id]) }

      context 'Comment posted by Strategy creator who is logged in' do
        before(:each) do
          sign_in user1
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user1.id, visibility: 'private', viewers: [user2.id])
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: "Visible only between you and #{user2.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end

      context 'Comment posted by Strategy viewer who is logged in' do
        before(:each) do
          sign_in user2
        end

        it 'generates a valid comment object when visbility is all' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end

        it 'generates a valid comment object when visbility is private' do
          new_comment = create(:comment, comment: comment, commentable_type: 'strategy', commentable_id: new_strategy.id, comment_by: user2.id, visibility: 'private', viewers: [user1.id])
          expect(controller.generate_comment(new_comment, 'strategy')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: "Visible only between you and #{user1.name}",
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end
    end

    context 'Meetings' do
      let(:new_meeting) { create :meeting }

      before do
        create :meeting_member, userid: user1.id, leader: true, meetingid: new_meeting.id
        create :meeting_member, userid: user2.id, leader: false, meetingid: new_meeting.id
      end

      context 'Comment posted by Meeting creator who is logged in' do
        it 'generates a valid comment object' do
          sign_in user1
          new_comment = create(:comment, comment: comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user1.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'meeting')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user1),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end

      context 'Comment posted by Meeting member who is logged in' do
        it 'generates a valid comment object' do
          sign_in user2
          new_comment = create(:comment, comment: comment, commentable_type: 'meeting', commentable_id: new_meeting.id, comment_by: user2.id, visibility: 'all')
          expect(controller.generate_comment(new_comment, 'meeting')).to include(
            commentid: new_comment.id,
            :profile_picture => be_avatar_component,
            comment_info: comment_info(user2),
            comment_text: comment,
            visibility: nil,
            delete_comment: delete_comment(new_comment.id),
            no_save: false
          )
        end
      end
    end
  end
end
