# frozen_string_literal: true
class RecaptchaService
  MIN_ATTEMPTS_FOR_RECAPTCHA = 3

  def initialize(user)
    @user = user
  end

  def self.recaptcha_configured?
    Recaptcha.configuration.site_key.present? &&
      Recaptcha.configuration.secret_key.present?
  end

  def recaptcha_required_for_login?
    return false unless self.class.recaptcha_configured?

    failed_attempts = @user.failed_attempts.to_i
    failed_attempts >= MIN_ATTEMPTS_FOR_RECAPTCHA
  end
end
