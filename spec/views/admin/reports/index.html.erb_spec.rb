require 'rails_helper'

RSpec.describe "admin/reports/index", type: :view do
  before(:each) do
    assign(:admin_reports, [
      Admin::Report.create!(),
      Admin::Report.create!()
    ])
  end

  it "renders a list of admin/reports" do
    render
  end
end
