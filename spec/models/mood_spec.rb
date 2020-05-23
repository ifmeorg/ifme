# frozen_string_literal: true
# == Schema Information
#
# Table name: moods
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

describe Mood do
  it { is_expected.to respond_to :friendly_id }

  context 'with relations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :name }
  end

  context 'with validations' do
    it { is_expected.to belong_to :user }
  end

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
