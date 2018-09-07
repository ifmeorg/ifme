# == Schema Information
#
# Table name: reports
#
#  reporter_id         :integer
#  reportee_id         :integer
#  reasons             :text
#  comment_id          :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
RSpec.describe Report, type: :model do
  
    describe '#reports' do
      it "has a valid factory" do
          expect(FactoryBot.build(:report)).to be_valid
      end
      it 'is valid with reporter_id, reportee_id, reasons' do
          report = Report.new(
          reporter_id: "1",
          reportee_id: "2",
          reasons: "You have been reported."
          )
      expect(report).to be_valid
      end
      it 'is invalid without reporter_id' do
          report = Report.new(reporter_id: nil)
          report.valid?
          expect(report.errors[:reporter_id]).to include("can't be blank")        
      end
      it 'is invalid without reportee_id' do
          report = Report.new(reportee_id: nil)
          report.valid?
          expect(report.errors[:reportee_id]).to include("can't be blank")        
      end
      it 'is invalid without comments' do
          report = Report.new(reasons: nil)
          report.valid?
          expect(report.errors[:reasons]).to include("can't be blank")        
      end
    end
    
    describe "#testing associations" do
      it "Reports can only be created by users" do
        t = Report.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
      it "Reports belong to reporter" do
          t = Report.reflect_on_association(:reporter)
          expect(t.macro).to eq(:belongs_to)
      end
      it "Reports have to be created for reportee" do
          t = Report.reflect_on_association(:reportee)
          expect(t.macro).to eq(:belongs_to)
      end
      it "Reports have one comment" do
          t = Report.reflect_on_association(:comment)
          expect(t.macro).to eq(:has_one)
      end
    end
  
    describe "#send email after report creation" do
      subject { create :report }

      it 'sends an email' do
        expect { subject.send_mail_reports }
          .to change { ActionMailer::Base.deliveries.count }.by(4)
      end
    end
  end
  
