require 'rails_helper'

RSpec.describe "admin/reports/new", type: :view do
  before(:each) do
    assign(:admin_report, Admin::Report.new())
  end

  it "renders new admin_report form" do
    render

    assert_select "form[action=?][method=?]", admin_reports_path, "post" do
    end
  end
end
