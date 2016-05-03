require 'rails_helper'

describe ApplicationHelper do
  describe "#nav_link_to" do
    let(:is_active) { true }
    let(:label)     { "foo" }
    let(:path)      { "bar" }
    let(:options)   { {} }

    subject { nav_link_to(label, path, options) }

    before(:each) do
      allow(self).to receive("is_active?").and_return(is_active)
    end

    context "when active" do
      let(:is_active) { true }

      it { is_expected.to have_selector "li a" }
      it { is_expected.to include label }
      it { is_expected.to have_selector "li.active" }
    end

    context "when not active" do
      let(:is_active) { false }

      it { is_expected.to have_selector "li a" }
      it { is_expected.to include label }
      it { is_expected.not_to have_selector "li.active" }
    end

    context "when options include method" do
      let(:options) { { :method => :delete } }

      it "passes method in environment" do
        expect(self).to receive(:is_active?).with(path, options)
        nav_link_to(label, path, options)
      end
    end
  end

  describe "#is_active?" do
    let(:is_current_page)    { false }
    let(:current_controller) { "" }
    let(:action_name)        { "" }
    let(:path)               { root_path }
    let(:environment)        { {} }

    subject { is_active?(path, environment) }

    before(:each) do
      params[:controller] = current_controller
      allow(controller).to receive(:action_name).and_return(action_name)
      allow(self).to receive("current_page?").and_return(is_current_page)
    end

    context "current page" do
      let(:is_current_page) { true }
      it { is_expected.to be true }
    end

    context "current controller" do
      let(:current_controller) { "moments" }
      let(:path)               { new_moment_path }

      it { is_expected.to be true }
    end

    context "current controller and profile" do
      let(:current_controller) { "profile" }
      let(:path)               { "profile?userid=2" }

      it { is_expected.to be false }
    end

    context "parent of active controller" do
      let(:current_controller) { "categories" }
      let(:path)               { moments_path }

      it { is_expected.to be true }
    end

    context "new user session with devise" do
      let(:current_controller) { "devise/sessions" }
      let(:action_name)        { "new" }
      let(:path)               { new_user_session_path }

      it { is_expected.to be true }
    end

    context "new user registration with devise" do
      let(:current_controller) { "devise/registrations" }
      let(:action_name)        { "create" }
      let(:path)               { new_user_registration_path }

      it { is_expected.to be true }
    end

    context "sign out" do
      let(:current_controller) { "profile" }
      let(:path)               { destroy_user_session_path }
      let(:environment)        { { :method => :delete } }

      it { is_expected.to be false }
    end
  end
end