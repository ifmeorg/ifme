# == Schema Information
#
# Table name: moments
#
#  id         :integer          not null, primary key
#  category   :text
#  name       :string
#  mood       :text
#  why        :text
#  fix        :text
#  created_at :datetime
#  updated_at :datetime
#  userid     :integer
#  viewers    :text
#  comment    :boolean
#  strategies :text
#

describe Moment do
	describe "POST create" do
		it "create private moment" do
			new_user = create(:user1)
			new_category = create(:category, userid: new_user.id)
			new_mood = create(:mood, userid: new_user.id)
			new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
			expect(new_moment.viewers).to be_empty
    end
  end

	describe "POST create" do
		it "create public moment" do
			new_user = create(:user1)
			new_user2 = create(:user2)
			new_allies = create(:allyships_accepted, user_id: new_user.id, ally_id: new_user2.id)
				new_category = create(:category, userid: new_user.id)
			new_mood = create(:mood, userid: new_user.id)
			new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), viewers: [new_user2.id])
			expect(new_moment.viewers.count).to eq(1)
		end
  end

  context 'instance methods' do
    describe '#array_data' do
      let(:user_id) { create(:user1).id }

      subject { create(:moment, userid: user_id) }

      it 'instantiates categories attribute if not empty' do
        subject.category = create_list(:category, 2, userid: user_id).map(&:id)

        expect(subject).to receive(:category=).with(subject.category)

        subject.save
      end

      it 'instantiates strategies attribute if not empty' do
        subject.strategies = create_list(:strategy, 2, userid: user_id).map &:id

        expect(subject).to receive(:strategies=).with(subject.strategies)

        subject.save
      end

      it 'instantiates mood attribute if not empty' do
        subject.mood = create_list(:mood, 2, userid: user_id).map(&:id)

        expect(subject).to receive(:mood=).with(subject.mood)

        subject.save
      end

      it 'instantiates viewers attribute if not empty' do
        subject.viewers = create_list(:user1, 2).map(&:id)

        expect(subject).to receive(:viewers=).with(subject.viewers)

        subject.save
      end
    end
  end
end
