# == Schema Information
#
# Table name: reports
#  reporter_id             :string        
#  reportee_id             :string
#  comments                :text
#  commentable_type        :string
#  commentable_id          :integer

# frozen_string_literal: true

RSpec.describe ReportsController, type: :controller do
  
    describe '#reports' do
        it "has a valid factory" do
            expect(FactoryBot.build(:report)).to be_valid
        end
    end

    # it 'is valid with reporter_id, reportee_id, comments_id' do
    #     report = Report.new(
    #     reporter_id: "1",
    #     reportee_id: "2",
    #     comments: "You have been reported."
    #     )
    #     expect(report).to be_valid
    # end
    # it 'is invalid without reporter_id' do
    #     report = Report.new(reporter_id: nil)
    #     report.valid?
    #     expect(report.errors[:reporter_id]).to include("can't be blank")        
    # end
    # it 'is invalid without reportee_id' do
    #     report = Report.new(reportee_id: nil)
    #     report.valid?
    #     expect(report.errors[:reportee_id]).to include("can't be blank")        
    # end
    # it 'is invalid without comments' do
    #     report = Report.new(comments: nil)
    #     report.valid?
    #     expect(report.errors[:comments]).to include("can't be blank")        
    # end
         

    # describe "#create" do
    #     context "as an authenticated user" do
    #         before do
    #             @report = FactoryBot.create(:report)
    #         end
    #     it "adds a project" do
    #         report_params = FactoryBot.attributes_for(:report)
    #         sign_in @user
    #         expect {
    #         report :create, params: { report: report_params }
    #         }.to change(@user.reports, :count).by(1)
    #     end
    #     end
    # end
end
  