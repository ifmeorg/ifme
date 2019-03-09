# frozen_string_literal: true
describe MomentsStatsHelper, type: :controller do
  let(:user) { create(:user1) }

  controller(MomentsController) do
  end

  describe '#moments_stats' do
    before(:example) do
      sign_in user
    end

    it 'has no moments' do
      expect(controller.moments_stats).to eq('')
    end

    it 'has one moment' do
      new_moment = create(:moment, user_id: user.id)
      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>1</strong> moment.</div>')
    end

    it 'has more than one moment created this month' do
      new_moment1 = create(:moment, user_id: user.id)
      new_moment2 = create(:moment, user_id: user.id)
      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>2</strong> moments.</div>')
    end

    it 'has more than one moment created on different months' do
      new_moment1 = create(:moment, user_id: user.id, created_at: '2014-01-01 00:00:00')
      new_moment2 = create(:moment, user_id: user.id)

      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>2</strong> moments. This <strong>month</strong> you wrote <strong>1</strong> moment.</div>')

      new_moment3 = create(:moment, user_id: user.id)

      expect(controller.moments_stats).to eq('<div class="center stats">You have written a <strong>total</strong> of <strong>3</strong> moments. This <strong>month</strong> you wrote <strong>2</strong> moments.</div>')
    end
  end
end
