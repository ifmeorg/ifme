# frozen_string_literal: true

module PasswordValidatable
  extend ActiveSupport::Concern

  PWD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*$/

  private

  def password_complexity
    return if valid_pwd?

    err_mess = I18n.t('devise.registrations.password_complexity_error')
    errors.add(:password, err_mess)
  end

  def valid_pwd?
    google_oauth2_enabled? || password.blank? || (password =~ PWD_REGEX)
  end
end
