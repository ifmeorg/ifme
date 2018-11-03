# == Schema Information
#
# Table name: reports
#  reporter_id             :string
#  reportee_id             :string
#  comments                :text
#  commentable_type        :string
#  commentable_id          :integer

describe ReportsController, type: :controller do
  describe "#create" do
    context "as an authenticated user" do
      before do
        @report = create(:report)
      end
      it "adds a report" do
        report_params = attributes_for(:report)
        expect {
          report :create, params: { report: report_params }
        }
      end
    end
  end
end
