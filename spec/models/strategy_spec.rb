# == Schema Information
#
# Table name: strategies
#
#  id                   :integer          not null, primary key
#  userid               :integer
#  category             :text
#  description          :text
#  viewers              :text
#  comment              :boolean
#  created_at           :datetime
#  updated_at           :datetime
#  name                 :string
#  self_care_strategy   :string
#

describe Strategy do
	describe 'when a strategy is successfully created' do
	 	it "creates a strategy" do
	 		new_user1 = create(:user1)
	 		new_category = create(:category, userid: new_user1.id)
	 		new_user2 = create(:user2)
	 		new_strategy = create(:strategy, userid: new_user1.id, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
		  	expect(Strategy.count).to eq(1)
	 	end
	end

    describe 'when a strategy created but did not save' do
	 	it "does not create a strategy" do
	 		new_user1 = create(:user1)
	 		new_category = create(:category, userid: new_user1.id)
	 		new_user2 = create(:user2)
	 		new_strategy = build(:strategy, category: Array.new(1, new_category.id), viewers: Array.new(1, new_user2.id))
		  	expect(new_strategy).to have(1).error_on(:userid)
	 	end
	end

	describe '#active_reminders' do
	    let(:user) { FactoryGirl.create(:user1) }
	    subject { strategy.active_reminders }

	    describe 'when strategy has no reminders' do
	      let(:strategy) { FactoryGirl.create(:strategy, userid: user.id) }

	      it 'returns an empty list' do
	        expect(subject).to eq([])
	      end
	  	end

		describe 'when strategy has self care strategy reminder' do
	      let(:strategy) { FactoryGirl.create(:strategy, :with_self_care_strategy_reminder, userid: user.id) }

	      it 'is a list containing self care reminders' do
	        expect(subject).to eq([strategy.self_care_strategy_reminder])
	      end
	    end

	    describe 'when strategy has daily reminder' do
	      let(:strategy) { FactoryGirl.create(:strategy, :with_daily_reminder, userid: user.id) }

	      it 'is a list containing the daily reminder' do
	        expect(subject).to eq([strategy.strategy_reminder])
	      end
	    end

	    describe 'when strategy has both reminders' do
	      let(:strategy) { FactoryGirl.create(:strategy, :with_both_reminders, userid: user.id) }

	      it 'is a list containing both reminders' do
	        expect(subject).to eq([strategy.self_care_strategy_reminder, strategy.strategy_reminder])
	      end
	    end
	end
end
