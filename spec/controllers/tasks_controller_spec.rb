# frozen_string_literal: true

describe TasksController do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe '#index' do
    let(:task) { create(:task, title: 'test') }

    context 'when the user is logged in' do
      include_context :logged_in_user
    end

    context 'when the user is not logged in' do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
