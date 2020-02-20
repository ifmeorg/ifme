# frozen_string_literal: true
# == Schema Information
#
# Table name: moment_moods
#
#  id                :bigint(8)        not null, primary key
#  moment_id         :bigint
#  mood_id           :bigint
#

describe MomentMood do
  context 'with relations' do
    it { is_expected.to belong_to :moment }
    it { is_expected.to belong_to :mood }
  end
end
