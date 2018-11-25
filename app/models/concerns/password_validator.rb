# frozen_string_literal: true
module PasswordValidator
  extend ActiveSupport::Concern

  MAX_PREVIOUS_PASSWORD = 3
  PASSWORD_VALIDITY_MONTHS = 12

  def password_needs_update?
    return false if google_oauth2_enabled?

    no_histories? || outdated_password?
  end

  private

  def outdated_password?
    updated_on = password_histories.last.try(:created_at)
    return false unless updated_on

    (updated_on + PASSWORD_VALIDITY_MONTHS.months) < Time.zone.now
  end

  def no_histories?
    password_histories.empty?
  end

  def create_password_history
    return unless saved_change_to_encrypted_password?

    password_histories.create(encrypted_password: encrypted_password)

    return if password_histories.count <= MAX_PREVIOUS_PASSWORD

    password_histories.first.destroy
  end

  def password_complexity
    google_oauth2_enabled? ||
      password.blank? ||
      (!saved_change_to_encrypted_password? && strong_password?)
  end

  def strong_password?
    matches_format? && not_a_used_password?
  end

  def matches_format?
    password_regex =
      /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*$/
    return true if password =~ password_regex

    errors.add(:password, I18n.t('devise.registrations.password_errors.format'))
    false
  end

  def not_a_used_password?
    password_histories.pluck(:encrypted_password).each do |encrypted_password|
      next unless matches_with?(encrypted_password)

      message = I18n.t('devise.registrations.password_errors.used')
      errors.add(:password, message)

      return false
    end
    true
  end

  def matches_with?(old_encrypted_password)
    bcrypt = ::BCrypt::Password.new(old_encrypted_password)
    hashed_value = ::BCrypt::Engine.hash_secret(
      [password, Devise.pepper].join, bcrypt.salt
    )

    hashed_value == old_encrypted_password
  end
end
