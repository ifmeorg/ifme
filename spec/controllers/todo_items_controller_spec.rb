# frozen_string_literal: true

describe TodoItemsController do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe '#create' do
    let(:todo_item) { create(:todo_item, title: 'test') }

    context 'when the user is logged in' do
      include_context :logged_in_user
    end

    context 'when the user is not logged in' do
      include_context :with_no_logged_in_user
    end
  end
end
