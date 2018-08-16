require 'rails_helper'

RSpec.describe "admin/reports/edit", type: :view do
  before(:each) do
    @admin_report = assign(:admin_report, Admin::Report.create!())
  end

  it "renders the edit admin_report form" do
    render

    assert_select "form[action=?][method=?]", admin_report_path(@admin_report), "post" do
    end
  end
end
