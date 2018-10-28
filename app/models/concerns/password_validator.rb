# frozen_string_literal: true

module PasswordValidator
  extend ActiveSupport::Concern

  PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*$/

  private

  def password_complexity
    return if good_password?

    error_message = I18n.t('devise.registrations.password_complexity_error')
    errors.add(:password, error_message)
  end

  def good_password?
    google_oauth2_enabled? || password.blank? || (password =~ PASSWORD_REGEX)
  end
end
