# frozen_string_literal: true

describe PasswordValidator, type: :model do
  let(:user) { build(:user, password: nil) }

  describe '#password_validations' do
    context 'when password is blank' do
      it 'throws password error only from devise' do
        expect(user.valid?).to be false

        expect(user).to have(1).error_on(:password)
        expect(user.errors[:password]).not_to include(I18n.t('devise.registrations.password_errors.format'))
      end
    end

    context 'when Google auth is enabled' do
      let(:user) { build(:user_oauth) }

      it "doesn't throw any errors even if the password strength is weak" do
        user.password = 'warsdasdf'
        user.token = 'access token'
        expect(user.valid?).to be true
      end
    end

    context 'when password is valid' do
      it "doesn't throw any errors" do
        user.password = 'waspAr$0'
        expect(user.valid?).to be true
      end
    end

    context 'when password is invalid' do
      it 'returns respective error message' do
        ['waspar$0', 'waspaRs0', 'waspar$o', 'WASPAR$0', 'Was$0'].each do |password|
          user.password = password
          expect(user.valid?).to be false
          expect(user).to have(1).error_on(:password)
        end
      end
    end
  end

  context '#password_needs_update' do
    context 'with Google auth user' do
      let(:user) { build(:user_oauth) }

      it 'returns false' do
        expect(user.password_needs_update?).to be false
      end
    end
  end
end
