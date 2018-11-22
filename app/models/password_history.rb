# frozen_string_literal: true

# == Schema Information
#
# Table name: password_histories
#
#  id                     :integer          not null, primary key
#  user_id                :integer           default(''), not null
#  encrypted_password     :string           default(''), not null

class PasswordHistory < ApplicationRecord
  belongs_to :user

  validates :encrypted_password, presence: true, uniqueness: { scope: :user_id }
end
