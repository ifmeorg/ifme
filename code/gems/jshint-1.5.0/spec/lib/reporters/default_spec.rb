require 'spec_helper'
require 'jshint/reporters'

describe Jshint::Reporters::Default do
  let(:results) {
    {"app/assets/javascripts/angular/controllers/feeds_controller.js"=>
    [{"id"=>"(error)",
      "raw"=>"'{a}' is not defined.",
      "code"=>"W117",
      "evidence"=>
       "app.controller(\"FeedsController\", function($scope, $rootScope, feedsService) {",
      "line"=>1,
      "character"=>1,
      "scope"=>"(main)",
      "a"=>"app",
      "b"=>nil,
      "c"=>nil,
      "d"=>nil,
      "reason"=>"'app' is not defined."},
     {"id"=>"(error)",
      "raw"=>"'{a}' is not defined.",
      "code"=>"W117",
      "evidence"=>"    angular.forEach(data, function(value, key) {",
      "line"=>13,
      "character"=>5,
      "scope"=>"(main)",
      "a"=>"angular",
      "b"=>nil,
      "c"=>nil,
      "d"=>nil,
      "reason"=>"'angular' is not defined."},
     {"id"=>"(error)",
      "raw"=>"'{a}' is defined but never used.",
      "code"=>"W098",
      "evidence"=>"    angular.forEach(data, function(value, key) {",
      "line"=>13,
      "character"=>46,
      "scope"=>"(main)",
      "a"=>"key",
      "b"=>nil,
      "c"=>nil,
      "d"=>nil,
      "reason"=>"'key' is defined but never used."}]
    }
  }
  subject { described_class.new(results) }

  it "should initialize output to be an empty string" do
    expect(subject.output).to eq('')
  end

  describe "print_footer" do
    it "should output a footer starting with a new line feed" do
      expect(subject.print_footer(3)).to start_with("\n")
    end

    it "should output a footer containing '3 errors'" do
      expect(subject.print_footer(3)).to include("3 errors")
    end

    it "should output a footer containing '1 error'" do
      expect(subject.print_footer(1)).to include("1 error")
    end
  end

  describe "print_errors_for_file" do
    before do
      subject.print_errors_for_file("app/assets/javascripts/angular/controllers/feeds_controller.js", results["app/assets/javascripts/angular/controllers/feeds_controller.js"])
    end

    it "should add 3 entries in to the error output" do
      expect(subject.output.split(/\r?\n/).length).to eq(3)
    end

    it "should contain the line number in to the error output" do
      expect(subject.output).to include("line 1")
    end

    it "should contain the column number in to the error output" do
      expect(subject.output).to include("col 1")
    end

    it "should contain the filename in to the error output" do
      expect(subject.output).to include("app/assets/javascripts/angular/controllers/feeds_controller.js")
    end

    it "should contain the nature of the error in to the error output" do
      expect(subject.output).to include("'app' is not defined")
    end
  end

  describe "report" do
    it "should call print errors for file 1 time" do
      expect(subject).to receive(:print_errors_for_file)
      subject.report
    end

    it "should print the report footer" do
      expect(subject).to receive(:print_footer).with(3)
      subject.report
    end

    it "should return a thorough report" do
      expect(subject.report.length).to be >= 10
    end

    it "should return 0 errors when it has no results" do
      subject.instance_variable_set(:@results, {})
      expect(subject.report).to include "0 errors"
    end
  end
end
