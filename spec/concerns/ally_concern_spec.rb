# frozen_string_literal: true
describe AllyConcern, type: :model do

  describe '#ally?' do
    let(:banned) { false }
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2, banned: banned) }

    context 'users are allies' do
      before do
        create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns true' do
          expect(user1.ally?(user2)).to eq(true)
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns true' do
          expect(user1.ally?(user2)).to eq(false)
        end
      end
    end

    context 'users are not allies' do
      it 'returns false' do
        expect(user1.ally?(user2)).to eq(false)
      end
    end
  end

  describe '#allies_by_status' do
    let(:banned) { false }
    let(:user1) { create(:user1) }
    let(:user2) { create(:user2, banned: banned) }

    context 'has accepted status' do
      before do
        create(:allyships_accepted, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns array with ally' do
          expect(user1.allies_by_status(:accepted)).to eq([user2])
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns empty array' do
          expect(user1.allies_by_status(:accepted)).to eq([])
        end
      end
    end

    context 'has pending_from_user status' do
      before do
        create(:allyships_pending_from_user_id1, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns array with ally' do
          expect(user1.allies_by_status(:pending_from_user)).to eq([user2])
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns empty array' do
          expect(user1.allies_by_status(:pending_from_user)).to eq([])
        end
      end
    end

    context 'has pending_from_ally status' do
      before do
        create(:allyships_pending_from_user_id2, user_id: user1.id, ally_id: user2.id)
      end

      context 'ally is not banned' do
        it 'returns array with ally' do
          expect(user1.allies_by_status(:pending_from_ally)).to eq([user2])
        end
      end

      context 'ally is banned' do
        let(:banned) { true }

        it 'returns empty array' do
          expect(user1.allies_by_status(:pending_from_ally)).to eq([])
        end
      end
    end
  end
end
