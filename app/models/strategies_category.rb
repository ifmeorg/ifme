# frozen_string_literal: true
# == Schema Information
#
# Table name: strategies_categories
#
#  id          :bigint           not null, primary key
#  strategy_id :integer
#  category_id :integer
#

class StrategiesCategory < ApplicationRecord
  belongs_to :strategy
  belongs_to :category

  validates :strategy_id, uniqueness: { scope: :category_id }
end
