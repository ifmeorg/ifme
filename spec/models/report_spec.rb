# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  reporter_id :integer
#  reportee_id :integer
#  reasons     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  comment_id  :integer
#  user_id     :integer
#

RSpec.describe Report, type: :model do
  
  describe '#reports' do
    it "has a valid factory" do
        expect(FactoryBot.build(:report)).to be_valid
    end
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
