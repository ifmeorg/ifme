# frozen_string_literal: true
# == Schema Information
#
# Table name: moods
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  slug        :string
#

describe Mood do
  context 'creation' do
    it 'is valid' do
      mood = create(:mood, :with_user)
      expect(mood).to be_valid
      expect(Mood.count).to eq(1)
    end

    it 'is invalid without a user_id' do
      mood = build(:mood, user_id: nil)
      expect(mood).to be_invalid
    end

    it 'is invalid without a name' do
      mood = build(:mood, name: nil)
      expect(mood).to have(1).error_on(:name)
    end
  end

  context 'relation' do
    it 'belongs to a user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
