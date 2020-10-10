# frozen_string_literal: true

describe AlliesController do
  let(:user) { create(:user) }
  let(:ally) { create(:user, name: 'Marco') }
  let(:notification) { double(:notification) }

  describe '#index' do
    subject { get allies_path }

    context 'when user is logged in' do
      before { sign_in user }
      let (:incoming_ally) { create(:user, name: 'Stella') }
      let (:outgoing_ally) { create(:user, name: 'Sam') }
      let (:invited_ally) { create(:user, invited_by: user) }

      it 'returns a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'correctly includes pending and accepted allies' do
        allow(user).to receive(:allies_by_status).with(:accepted).and_return([ally])
        allow(user).to receive(:allies_by_status).with(:pending_from_user).and_return([incoming_ally])
        allow(user).to receive(:allies_by_status).with(:pending_from_ally).and_return([outgoing_ally])
        subject
        expect(response.body).to include('Stella') && include('Marco') && include('Sam')
      end
    end

    context 'when user is not logged in' do
      before { subject }

      it_behaves_like :with_no_logged_in_user
    end
  end
end
