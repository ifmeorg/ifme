# frozen_string_literal: true
# == Schema Information
#
# Table name: moments_strategies
#
#  id          :bigint           not null, primary key
#  moment_id   :integer
#  strategy_id :integer
#

class MomentsStrategy < ApplicationRecord
  belongs_to :moment
  belongs_to :strategy

  validates :moment_id, uniqueness: { scope: :strategy_id }
end
