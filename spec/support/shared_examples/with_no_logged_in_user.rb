# frozen_string_literal: true

shared_examples_for :with_no_logged_in_user do
  it 'redirects to sign_in page' do
    expect(response).to redirect_to new_user_session_path
  end
end
