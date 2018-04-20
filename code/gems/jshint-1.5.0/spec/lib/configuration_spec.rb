require 'spec_helper'
require 'jshint/configuration'

describe Jshint::Configuration do
  let(:config) { File.join(Jshint.root, 'spec', 'fixtures', 'jshint.yml') }

  describe "core behaviour" do
    before do
      allow_any_instance_of(described_class).
        to receive(:default_config_path).and_return('/foo/bar.yml')
      allow_any_instance_of(described_class).
        to receive(:parse_yaml_config).and_return(YAML.load_file(config))
    end

    it "should allow the developer to index in to config options" do
      config = described_class.new
      expect(config[:boss]).to be_truthy
      expect(config[:browser]).to be_truthy
    end

    it "should return a Hash of the global variables declared" do
      config = described_class.new
      expect(config.global_variables).to eq({ "jQuery" => true, "$" => true })
    end

    it "should return a Hash of the lint options declared" do
      config = described_class.new
      expect(config.lint_options).
        to eq(config.options["options"].reject { |key| key == "globals" })
    end

    it "should return an array of files" do
      config = described_class.new
      expect(config.files).to eq(["**/*.js"])
    end

    context "search paths" do
      subject { described_class.new }

      it "should default the exclusion paths to an empty array" do
        expect(subject.exclude_paths).to eq([])
      end

      describe "include search paths" do
        it "should set the exclusion paths to those in the config" do
          subject.options["include_paths"] ||= []
          subject.options["include_paths"] << 'spec/javascripts'
          expect(subject.include_paths).to eq(["spec/javascripts"])
          expect(subject.search_paths).to include("spec/javascripts")
        end
      end

      describe "exclude search paths" do
        it "should set the exclusion paths to those in the config" do
          subject.options["exclude_paths"] << 'vendor/assets/javascripts'
          expect(subject.exclude_paths).to eq(["vendor/assets/javascripts"])
        end
      end
    end

    context "javascript_files" do
      it "knows what files to include by default" do
        expect(subject.javascript_files).to eq(["vendor/assets/javascripts/jshint.js"])
      end
      it "knows what files to include when specifying include files and inlude paths" do
        subject.options["include_paths"] = ["lib/jshint"]
        subject.options["files"] = ["**/*.rake"]
        expect(subject.javascript_files).to eq(["lib/jshint/tasks/jshint.rake"])
      end
      it "knows what files to exclude when specifying exclude files" do
        subject.options["exclude_files"] = ["**/*jshi*"]
        expect(subject.javascript_files).to eq([])
      end
      it "knows what files to exclude when specifying exclude paths" do
        subject.options["exclude_paths"] = ["vendor"]
        expect(subject.javascript_files).to eq([])
      end
    end

    context "get_files" do
      it "gets all matching files in given search paths" do
        expect(subject.send(:get_files, ["vendor"], ["**/*.js"])).to eq(["vendor/assets/javascripts/jshint.js"])
      end
    end
  end
end
