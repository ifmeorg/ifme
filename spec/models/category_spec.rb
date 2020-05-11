# frozen_string_literal: true
# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  slug        :string
#  visible     :boolean          default(TRUE)
#

describe Category do
  it { is_expected.to respond_to :friendly_id }

  context 'with validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :name }

    it 'is invalid without a name' do
      category = build(:category, name: nil)
      expect(category).to have(1).error_on(:name)
    end
  end

  context 'with relations' do
    it { is_expected.to belong_to :user }
  end
end
