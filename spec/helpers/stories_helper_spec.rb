# frozen_string_literal: true

describe StoriesHelper, type: :controller do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }

  class FakeStoriesController < ApplicationController
    include StoriesHelper
  end

  controller(FakeStoriesController) do
  end

  describe '#get_stories' do
    let(:user_id) { user1.id }
    let(:moment) { create(:moment, user_id: user_id) }
    let(:strategy) { create(:strategy, user_id: user_id) }

    before { sign_in user1 }

    context 'when not including allies' do
      subject { controller.get_stories(user1) }

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
      let(:timestamp) { Time.now.in_time_zone }
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
