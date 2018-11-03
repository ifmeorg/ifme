# frozen_string_literal: true
module PasswordValidator
  extend ActiveSupport::Concern

  PASSWORD_REGEX =
    /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*$/.freeze

  private

  def password_complexity
    return if good_password?

    error_message = t('devise.registrations.password_complexity_error')
    errors.add(:password, error_message)
  end

  def good_password?
    google_oauth2_enabled? || password.blank? || (password =~ PASSWORD_REGEX)
  end
end
