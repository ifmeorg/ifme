load File.join(File.dirname(__FILE__), 'spec_helper.rb')
require 'advisory_example'

shared_examples_for "Rubies Advisory" do |path|
  include_examples 'Advisory', path
  
  advisory = YAML.load_file(path)

  describe path do
    let(:engine) { File.basename(File.dirname(path)) }

    describe "engine" do
      subject { advisory['engine'] }

      it { is_expected.to be_kind_of(String) }
      it "should be equal to filename (case-insensitive)" do
        expect(subject.downcase).to eq(engine.downcase)
      end
    end
  end

end

