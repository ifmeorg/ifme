require 'spec_helper'
require 'jshint'

describe Jshint do
  describe ".class methods" do
    it "should return the root path of the gem" do
      expect(described_class.root).to eq(File.expand_path('../..', __FILE__))
    end
  end
end
