require "rails_helper"

RSpec.describe Admin::ReportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/reports").to route_to("admin/reports#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/reports/new").to route_to("admin/reports#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/reports/1").to route_to("admin/reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/reports/1/edit").to route_to("admin/reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/reports").to route_to("admin/reports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/reports/1").to route_to("admin/reports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/reports/1").to route_to("admin/reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/reports/1").to route_to("admin/reports#destroy", :id => "1")
    end

  end
end
