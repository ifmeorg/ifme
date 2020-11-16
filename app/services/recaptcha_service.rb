# frozen_string_literal: true
class RecaptchaService
  def initialize(user)
    @user = user
  end

  def recaptcha_required_for_login?
    failed_attempts = @user.failed_attempts.to_i
    failed_attempts >= 3
  end
end
