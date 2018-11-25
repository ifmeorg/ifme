# frozen_string_literal: true

# == Schema Information
#
# Table name: password_histories
#
#  id                     :integer          not null, primary key
#  user_id                :integer           default(''), not null
#  encrypted_password     :string           default(''), not null

describe PasswordHistory do
  let!(:password_history1) { FactoryBot.create(:password_history) }
  let(:password_history2) { FactoryBot.build(:password_history,
    encrypted_password: password_history1.encrypted_password)
  }

  context 'validations' do
    context 'encrypted_password' do
      context 'presence' do
        it 'should not be valid when its not present' do
          password_history1.encrypted_password = nil

          expect(password_history1.valid?).to be false
        end
      end

      context 'uniqueness scoped to user' do
        it 'should be valid when has duplicate, but scoped to different user' do
          expect(password_history2.valid?).to be true
        end

        it 'should not be valid when has duplicate, scoped to same user' do
          password_history2.user = password_history1.user

          expect(password_history2.valid?).to be false
        end
      end
    end
  end
end
