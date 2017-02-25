# == Schema Information
#
# Table name: strategies
#
#  id          :integer          not null, primary key
#  userid      :integer
#  category    :text
#  description :text
#  viewers     :text
#  comment     :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string
#  slug        :string
#

describe Strategy do
 	it "creates a strategy" do
 		new_user1 = create(:user1)
 		new_category = create(:category, userid: new_user1.id)
 		new_user2 = create(:user2)
 		new_strategy = create(:strategy, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
	  	expect(Strategy.count).to eq(1)
 	end

 	it "does not create a strategy" do
 		new_user1 = create(:user1)
 		new_category = create(:category, userid: new_user1.id)
 		new_user2 = create(:user2)
 		new_strategy = build(:strategy, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
	  	expect(new_strategy).to have(1).error_on(:userid)
 	end

  describe '#active_reminders' do
    let(:user) { FactoryGirl.create(:user1) }
    let(:strategy) { FactoryGirl.create(:strategy, userid: user.id) }

    subject { strategy.active_reminders }

    describe 'when strategy has no reminders' do
      let(:strategy) { FactoryGirl.create(:strategy, userid: user.id) }

      it 'is an empty list' do
        expect(subject).to eq([])
      end
    end

    describe 'when strategy has daily reminder' do
      let(:strategy) { FactoryGirl.create(:strategy, :with_daily_reminder, userid: user.id) }

      it 'is a list containing the daily reminder' do
        expect(subject).to eq([strategy.perform_strategy_reminder])
      end
    end
  end
end
