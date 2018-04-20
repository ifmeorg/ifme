load File.join(File.dirname(__FILE__), 'spec_helper.rb')
require 'advisory_example'

shared_examples_for "Libraries Advisory" do |path|
  include_examples 'Advisory', path

  advisory = YAML.load_file(path)

  describe path do
    let(:library) { File.basename(File.dirname(path)) }

    describe "library" do
      subject { advisory['library'] }

      it { is_expected.to be_kind_of(String) }
      it "should be equal to filename (case-insensitive)" do
        expect(subject.downcase).to eq(library.downcase)
      end
    end
  end
end
