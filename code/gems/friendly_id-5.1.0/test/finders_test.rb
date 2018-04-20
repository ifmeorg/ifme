require "helper"

class JournalistWithFriendlyFinders < ActiveRecord::Base
  self.table_name = 'journalists'
  extend FriendlyId
  scope :existing, -> {where('1 = 1')}
  friendly_id :name, use: [:slugged, :finders]
end

class Finders < Minitest::Test

  include FriendlyId::Test

  def model_class
    JournalistWithFriendlyFinders
  end

  test 'should find records with finders as class methods' do
    with_instance_of(model_class) do |record|
      assert model_class.find(record.friendly_id)
    end
  end

  test 'should find records with finders on relations' do
    with_instance_of(model_class) do |record|
      assert model_class.existing.find(record.friendly_id)
    end
  end
end
