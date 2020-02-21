# frozen_string_literal: true
# == Schema Information
#
# Table name: moments_moods
#
#  id         :int        not null, primary key
#  mood_id    :int
#  moment_id  :int

class MomentsMood < ApplicationRecord
  belongs_to :moment
  belongs_to :mood

  validates :moment_id, uniqueness: { scope: :mood_id }
end
