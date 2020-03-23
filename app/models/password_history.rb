# frozen_string_literal: true

# == Schema Information
#
# Table name: password_histories
#
#  id                 :bigint           not null, primary key
#  user_id            :integer          not null
#  encrypted_password :string
#  created_at         :datetime         not null
#

class PasswordHistory < ApplicationRecord
  belongs_to :user

  validates :encrypted_password, presence: true, uniqueness: { scope: :user_id }
end
