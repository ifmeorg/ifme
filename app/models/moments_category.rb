# frozen_string_literal: true
# == Schema Information
#
# Table name: moments_categories
#
#  id          :bigint           not null, primary key
#  moment_id   :integer
#  category_id :integer
#

class MomentsCategory < ApplicationRecord
  belongs_to :moment
  belongs_to :category

  validates :moment_id, uniqueness: { scope: :category_id }
end
