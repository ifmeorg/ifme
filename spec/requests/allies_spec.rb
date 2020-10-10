# frozen_string_literal: true

describe AlliesController do
  let(:user) { create(:user) }
  let(:ally) { create(:user, name: 'Marco') }
  let(:notification) { double(:notification) }

  describe '#index' do
    subject { get allies_path }

    context 'when user is logged in' do
      before { sign_in user }

      it 'returns a successful response when hit' do
        expect(subject).to be_successful
      end
    end

    context 'when user is not logged in' do
      before { subject }

      it_behaves_like :with_no_logged_in_user
    end
  end
end
