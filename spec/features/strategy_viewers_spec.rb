require 'rails_helper'

RSpec.feature "UserViewsAStrategy", type: :feature do
  let(:user) { create :user2 }

  let!(:allies) do
    viewer_count.times do |i|
      ally = create :user1, name: "Ally #{i}"
      create :allyships_accepted, user_id: user.id, ally_id: ally.id
    end
    user.allies_by_status(:accepted)
  end

  let!(:strategy) { create(:strategy, userid: user.id, viewers: allies.map(&:id)) }

  feature 'Viewing a strategy' do
    context 'as the strategy owner' do
      before do
        login_as user
        visit strategy_path(strategy.id)
      end

      context 'with no other viewers' do
        let(:viewer_count) { 0 }

        it 'says there are no viewers' do
          within '.viewers_indicator' do
            expect(page).to have_content 'There are no viewers'
          end
        end
      end

      context 'with 1 other viewer' do
        let(:viewer_count) { 1 }

        it 'says there is one viewer' do
          within '.viewers_indicator' do
            expect(page).to have_content 'Ally 0 is a viewer'
          end
        end
      end

      context 'with 2 other viewers' do
        let(:viewer_count) { 2 }

        it 'says there are two viewers' do
          within '.viewers_indicator' do
            expect(page).to have_content 'Ally 0 and Ally 1 are viewers'
          end
        end
      end

      context 'with 3 other viewers' do
        let(:viewer_count) { 3 }

        it 'says there are three viewers' do
          within '.viewers_indicator' do
            expect(page).to have_content 'Ally 0, Ally 1, and Ally 2 are viewers'
          end
        end
      end
    end

    context 'as one of the viewers' do
      before do
        login_as allies.first
        visit strategy_path(strategy.id)
      end

      context 'when you are the only viewer' do
        let(:viewer_count) { 1 }

        it 'says you are the only viewer' do
          within '.viewers_indicator' do
            expect(page).to have_content 'You are the only viewer'
          end
        end
      end

      context 'when there are other viewers' do
        let(:viewer_count) { 2 }

        it 'says you are not the only viewer' do
          within '.viewers_indicator' do
            expect(page).to have_content 'You are not the only viewer.'
          end
        end
      end
    end
  end
end
