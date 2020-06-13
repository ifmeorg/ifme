# == Schema Information
#
# Table name: care_plan_contacts
#
#  id         :bigint           not null, primary key
#  name       :string
#  phone      :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

describe CarePlanContact do
  context 'with validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :name }

    it 'is invalid without a user_id' do
      care_plan_contact = build(:care_plan_contact, user_id: nil)
      expect(care_plan_contact).to have(1).error_on(:user_id)
    end

    it 'is invalid without a name' do
      care_plan_contact = build(:care_plan_contact, name: nil)
      expect(care_plan_contact).to have(1).error_on(:name)
    end
  end

  context 'with relations' do
    it { is_expected.to belong_to :user }
  end
end
