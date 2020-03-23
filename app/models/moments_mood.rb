# frozen_string_literal: true
# == Schema Information
#
# Table name: moments_moods
#
#  id        :bigint           not null, primary key
#  moment_id :integer
#  mood_id   :integer
#

class MomentsMood < ApplicationRecord
  belongs_to :moment
  belongs_to :mood

  validates :moment_id, uniqueness: { scope: :mood_id }
end
