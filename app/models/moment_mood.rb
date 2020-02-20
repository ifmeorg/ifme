# frozen_string_literal: true
# == Schema Information
#
# Table name: moment_moods
#
#  id                :bigint(8)        not null, primary key
#  moment_id         :bigint
#  mood_id           :bigint
#

class MomentMood < ApplicationRecord
  belongs_to :moment
  belongs_to :mood
end
