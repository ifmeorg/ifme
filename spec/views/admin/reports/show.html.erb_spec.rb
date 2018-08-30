require 'rails_helper'

RSpec.describe "admin/reports/show", type: :view do
  before(:each) do
    @admin_report = assign(:admin_report, Admin::Report.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
