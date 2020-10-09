# frozen_string_literal: true

module PasswordValidator
  extend ActiveSupport::Concern

  MAX_PREVIOUS_PASSWORD = 3
  PASSWORD_VALIDITY_MONTHS = 12

  def password_needs_update?
    !oauth_enabled?
  end

  private

  def password_complexity
    oauth_enabled? ||
      password.blank? ||
      (!saved_change_to_encrypted_password? && strong_password?)
  end

  def strong_password?
    matches_format?
  end

  def matches_format?
    password_regex =
      /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*$/
    return true if password.match?(password_regex)

    errors.add(:password, I18n.t('devise.registrations.password_errors.format'))
    false
  end
end
