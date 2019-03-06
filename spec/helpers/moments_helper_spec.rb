# frozen_string_literal: true
describe MomentsHelper, type: :controller do
  let(:user) { create(:user1) }
  let(:moment) { FactoryBot.create(:moment, :with_secret_share, user: user) }

  controller(MomentsController) do
  end

  describe 'moments_stats' do
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

  describe '#secret_share_props' do
    it 'returns the correct input' do
      input = { inputs: [
          {
            id: 'secretShare',
            type: 'text',
            name: 'secretShare',
            label: I18n.t('moments.secret_share.singular'),
            readOnly: true,
            value: secret_share_url(moment.secret_share_identifier),
            dark: true,
            copyOnClick: I18n.t('moments.secret_share.link_copied')
          }
        ], action: moment_path(moment)
      }
      expect(controller.secret_share_props(moment)).to eq(input)
    end
  end

  describe '#present_moment_or_strategy' do
    context 'when its moment' do
      let(:moment) { create(:moment, user: user) }
      subject { controller.present_moment_or_strategy(moment) }
      it 'returns correct data' do
        expect(subject.keys).to include(:name, :link, :actions, :storyType, :date)
        expect(subject[:link]).to eq(moment_path(moment))
        expect(subject[:name]).to eq(moment[:name])
      end
    end

    context 'when its strategy' do
      let(:strategy) { create(:strategy, user: user) }
      subject { controller.present_moment_or_strategy(strategy) }
      it 'returns correct data' do
        expect(subject.keys).to include(:name, :link, :actions, :storyType, :date)
        expect(subject[:link]).to eq(strategy_path(strategy))
        expect(subject[:name]).to eq(strategy[:name])
      end
    end
  end
end
