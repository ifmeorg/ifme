# frozen_string_literal: true
# == Schema Information
#
# Table name: reports
#
#  id          :bigint(8)        not null, primary key
#  reporter_id :integer
#  reportee_id :integer
#  reasons     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  comment_id  :integer
#

describe Report do
  let(:user1) { create(:user1) }
  let(:user2) { create(:user2) }
  let(:report_params) do
    {
      reporter_id: user1.id,
      reportee_id: user2.id,
      reasons: 'You have been reported.'
    }
  end

  describe '#new' do
    let(:error) { "can't be blank" }

    it 'is valid with reporter_id, reportee_id, reasons' do
      report = Report.new(report_params)
      expect(report).to be_valid
    end

    it 'is invalid without reporter_id' do
      report = Report.new(reporter_id: nil)
      report.valid?
      expect(report.errors[:reporter_id]).to include(error)
    end

    it 'is invalid without reportee_id' do
      report = Report.new(reportee_id: nil)
      report.valid?
      expect(report.errors[:reportee_id]).to include(error)
    end

    it 'is invalid without comments' do
      report = Report.new(reasons: nil)
      report.valid?
      expect(report.errors[:reasons]).to include(error)
    end
  end

  describe '#send_emails' do
    before(:all) { Devise.mailer.deliveries.clear }

    it 'sends emails successfully' do
      Report.create(report_params)
      expect(Devise.mailer.deliveries.count).to eq(2)
    end
  end
end
