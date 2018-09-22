# frozen_string_literal: true

describe AllyshipCreator do
  describe '#perform' do
    subject { described_class.perform }

    it 'calls .perform' do
      expect(described_class).to receive(:new).and_call_original

      subject
    end
  end

  describe '.perform' do
    subject { described_class.perform(params) }

    let(:user) { create(:user) }
    let(:ally) { create(:user, name: 'Ally') }
    let(:params) do
      {
        current_user: user,
        ally_id: ally.id
      }
    end

    context 'when new request' do
      context 'when valid' do
        it 'creates 2 allyships' do
          expect { subject }.to change(Allyship, :count).by(2)
        end

        it 'creates the user allyship' do
          subject
          expect(user.reload.allyships.count).to eq(1)
        end

        it 'creates the user allyship with pending_from_ally status' do
          subject
          expect(user.reload.allyships.first).to be_pending_from_ally
        end

        it 'creates the ally allyship' do
          subject
          expect(ally.reload.allyships.count).to eq(1)
        end

        it 'creates the user allyship with pending_from_ally status' do
          subject
          expect(user.reload.allyships.first).to be_pending_from_ally
        end

        it 'creates a notification about the allyship' do
          params = {
            pusher_type: 'new_ally_request',
            current_user: user,
            ally_id: ally.id
          }

          expect(Allyships::AllianceNotifier)
            .to receive(:perform).with(params).and_call_original

          subject
        end
      end

      context 'when invalid' do
        context 'without a current_user' do
          let(:user) { nil }

          it 'returns nil' do
            expect(subject).to be_nil
          end
        end

        context 'without an ally_id' do
          let(:ally) { double('ally', id: nil) }

          it 'returns nil' do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end
