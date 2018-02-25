# frozen_string_literal: true

# == Schema Information
#
# Table name: take_medication_reminders
#
#  id            :integer          not null, primary key
#  medication_id :integer          not null
#  active        :boolean          not null
#  created_at    :datetime
#  updated_at    :datetime
#

describe TakeMedicationReminder do
  let(:user) { FactoryGirl.create(:user1) }
  let(:medication) { FactoryGirl.create(:medication, userid: user.id) }
  let(:reminder) { 
    FactoryGirl.create(:take_medication_reminder, medication_id: medication.id) 
  }

  describe '#active_reminders' do                  
    it 'returns only active reminders' do
      expect(TakeMedicationReminder.active).to eq([reminder])
    end        
  end
  
  describe 'for_day' do    
    let!(:weekly_medication) { 
      FactoryGirl.create(:medication, userid: user.id, weekly_dosage: [0,2,4,6]) 
    }
    let!(:weekly_medication2) { 
      FactoryGirl.create(:medication, userid: user.id, weekly_dosage: [1,2,4,6]) 
    }
    
    it 'returns only sundays reminder' do
      expect(TakeMedicationReminder.for_day(0)).to eq(
        [weekly_medication.take_medication_reminder]
      )
    end
  end
end
