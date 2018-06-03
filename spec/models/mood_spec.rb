# == Schema Information
#
# Table name: moods
#
#  id             :integer          not null, primary key
#  name           :string
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  userid         :integer
#  slug           :string
#

describe Mood do
  let(:user) { create(:user1) }

  describe '.add_premade' do
    context 'new user without moods - before clicking premade' do
      it 'has no moods attached to user' do
        expect(user.moods).to eq([])
        expect(user.moods.size).to eq(0)
      end
    end

    context 'new user without moods - clicks on premade' do
      it 'attaches 5 default premade moods to user' do
        Mood.add_premade(user.id)

        expect(user.moods.size).to eq(5)
        expect(user.moods.pluck(:name)).to eq([
          "Accepting",
          "Ambitious",
          "Curious",
          "Resentful",
          "Hopeless"
        ])
      end
    end
  end
end
