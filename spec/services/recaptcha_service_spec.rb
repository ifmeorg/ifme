# frozen_string_literal: true

require 'spec_helper'

describe RecaptchaService do
  let(:failed_attempts) { 0 }
  let(:user) { create(:user, failed_attempts: failed_attempts) }

  subject { described_class.new(user) }

  describe '#recaptcha_required_for_login?' do
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
