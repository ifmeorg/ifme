# frozen_string_literal: true
require 'support'
require 'mustermann/equality_map'

RSpec.describe Mustermann::EqualityMap do
  before { GC.disable }
  after { GC.enable }

  describe :fetch do
    subject { Mustermann::EqualityMap.new }
    specify 'with existing entry' do
      next if subject.is_a? Hash
      subject.fetch("foo") { "foo" }
      result = subject.fetch("foo") { "bar" }
      expect(result).to be == "foo"
    end

    specify 'with GC-removed entry' do
      next if subject.is_a? Hash
      subject.fetch(String.new('foo')) { "foo" }
      expect(subject.map).to receive(:[]).and_return(nil)
      result = subject.fetch(String.new('foo')) { "bar" }
      expect(result).to be == "bar"
    end
  end
end
