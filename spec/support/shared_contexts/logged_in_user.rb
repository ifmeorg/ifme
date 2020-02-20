# frozen_string_literal: true

shared_context :logged_in_user do
  before do
    stub_current_user_with(user)
    allow(controller).to receive(:user_signed_in?).and_return(true)
  end
end
