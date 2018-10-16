# frozen_string_literal: true
# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  slug        :string
#

describe Category do
  context 'creation' do
    it 'is valid' do
      category = create(:category, :with_user)
      expect(category).to be_valid
      expect(Category.count).to eq(1)
    end

    it 'is invalid without a user_id' do
      category = build(:category, user_id: nil)
      expect(category).to be_invalid
    end

    it 'is invalid without a name' do
      category = build(:category, name: nil)
      expect(category).to have(1).error_on(:name)
    end
  end

  context 'relation' do
    it 'belongs to a user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
