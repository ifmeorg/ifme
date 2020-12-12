# frozen_string_literal: true

require 'spec_helper'

describe RecaptchaService do
  describe '#recaptcha_configured?' do
    subject { described_class.recaptcha_configured? }

    it 'returns true if site key and secret key are present' do
      configuration =
        instance_double(
          Recaptcha::Configuration,
          site_key: '11111',
          secret_key: '22222',
        )
      allow(Recaptcha).to receive(:configuration).and_return(configuration)

      expect(subject).to be true
    end

    it 'returns false if site key is blank' do
      configuration =
        instance_double(
          Recaptcha::Configuration,
          site_key: nil,
          secret_key: '22222',
        )
      allow(Recaptcha).to receive(:configuration).and_return(configuration)

      expect(subject).to be false
    end

    it 'returns false if secret key is blank' do
      configuration =
        instance_double(
          Recaptcha::Configuration,
          site_key: '11111',
          secret_key: nil,
        )
      allow(Recaptcha).to receive(:configuration).and_return(configuration)

      expect(subject).to be false
    end
  end

  describe '#recaptcha_required_for_login?' do
    it 'returns false if recaptcha is not configured' do
      allow(described_class).to receive(:recaptcha_configured?).and_return(false)
      user = create(:user, failed_attempts: 5)

      expect(described_class.new(user).recaptcha_required_for_login?).to be false
    end

    context 'when recaptcha is configured' do
      before do
        allow(described_class).to receive(:recaptcha_configured?).and_return(true)
      end

      it 'returns false if the user has no failed logins' do
        user = create(:user, failed_attempts: 0)
        expect(described_class.new(user).recaptcha_required_for_login?).to be false
      end

      it 'returns false if the user has less than 3 failed logins' do
        user = create(:user, failed_attempts: 2)
        expect(described_class.new(user).recaptcha_required_for_login?).to be false
      end

      it 'returns true if the user has 3 failed logins' do
        user = create(:user, failed_attempts: 3)
        expect(described_class.new(user).recaptcha_required_for_login?).to be true
      end

      it 'returns true if the user has more than 3 failed logins' do
        user = create(:user, failed_attempts: 4)
        expect(described_class.new(user).recaptcha_required_for_login?).to be true
      end
    end
  end
end
