# frozen_string_literal: true

require 'spec_helper'

describe RecaptchaService do
  let(:failed_attempts) { 0 }
  let(:user) { create(:user, failed_attempts: failed_attempts) }

  subject { described_class.new(user) }

  describe '#recaptcha_configured?' do
    let(:site_key) { '11111' }
    let(:secret_key) { '22222' }
    let(:configuration) {
      instance_double(
        Recaptcha::Configuration,
        site_key: site_key,
        secret_key: secret_key,
      )
    }

    before do
      allow(Recaptcha).to receive(:configuration).and_return(configuration)
    end

    context 'site key and secrete key are present' do

      it 'returns true' do
        expect(described_class.recaptcha_configured?).to be true
      end
    end

    context 'site key is blank' do
      let(:site_key) {}

      it 'returns false' do
        expect(described_class.recaptcha_configured?).to be false
      end
    end

    context 'secret key is blank' do
      let(:secret_key) {}
      
      it 'returns false' do
        expect(described_class.recaptcha_configured?).to be false
      end
    end
  end

  describe '#recaptcha_required_for_login?' do
    context 'recaptcha is not configured' do
      before do
        allow(described_class).to receive(:recaptcha_configured?).and_return(false)
      end

      it 'returns false' do
        expect(subject.recaptcha_required_for_login?).to be false
      end
    end

    context 'recaptcha is configured' do
      before do
        allow(described_class).to receive(:recaptcha_configured?).and_return(true)
      end

      context 'when the user has no failed logins' do
        it 'returns false' do
          expect(subject.recaptcha_required_for_login?).to be false
        end
      end

      context 'when the user has less than 3 failed logins' do
        let(:failed_attempts) { 2 }

        it 'returns false' do
          expect(subject.recaptcha_required_for_login?).to be false
        end
      end

      context 'when the user has 3 failed logins' do
        let(:failed_attempts) { 3 }

        it 'returns true' do
          expect(subject.recaptcha_required_for_login?).to be true
        end
      end

      context 'when the user has more than 3 failed logins' do
        let(:failed_attempts) { 4 }

        it 'returns true' do
          expect(subject.recaptcha_required_for_login?).to be true
        end
      end
    end
  end
end
