# frozen_string_literal: true
# == Schema Information
#
# Table name: moments_moods
#
#  id         :int        not null, primary key
#  mood_id    :int
#  moment_id  :int

class MomentsCategory < ApplicationRecord
  belongs_to :moment
  belongs_to :category

  validates :moment_id, uniqueness: { scope: :category_id }
end
