# frozen_string_literal: true
module PausedAccountConcern
  extend ActiveSupport::Concern

  ACTIONS_ALLOWED_WHILE_PAUSED = {
    'paused_accounts' => %w[show create destroy],
    'sessions' => %w[new create destroy],
    'registrations' => %w[destroy],
    'pages' => %w[toggle_locale]
  }.freeze

  private

  def restrict_paused_account
    return unless user_signed_in? && current_user.paused?
    return if ACTIONS_ALLOWED_WHILE_PAUSED.fetch(controller_name, [])
                                          .include?(action_name)

    redirect_to_path(paused_account_path)
  end
end
