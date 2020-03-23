# frozen_string_literal: true
# == Schema Information
#
# Table name: allyships
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  ally_id    :integer
#  status     :integer
#

describe Allyship do
  context 'with relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :ally }
  end

  context 'with enums' do
    it { is_expected.to define_enum_for :status }
  end

  context 'when creating allies relationship' do
    let(:user_id) { create(:user1).id }
    let(:ally_id) { create(:user2).id }

    context 'with valid ally relationship' do
      before { create(allyship_status, user_id: user_id, ally_id: ally_id) }

      context 'with accepted status' do
        let(:allyship_status) { :allyships_accepted }
        it { expect(Allyship.count).to eq 2 }
      end

      context 'with pending_from_user_id1 status' do
        let(:allyship_status) { :allyships_pending_from_user_id1 }
        it { expect(Allyship.count).to eq 2 }
      end

      context 'with pending_from_user_id2 status' do
        let(:allyship_status) { :allyships_pending_from_user_id2 }
        it { expect(Allyship.count).to eq 2 }
      end
    end

    context 'with invalid ally relationship' do
      let(:new_allies) { build(:allyships_accepted, user_id: user_id, ally_id: ally_id) }

      context 'when users are identical' do
        let(:ally_id) { user_id }
        it { expect(new_allies).to have(1).error_on(:user_id) }
      end

      context 'when user1 is nil' do
        let(:user_id) { nil }
        it { expect(new_allies).to have(1).error_on(:user_id) }
      end

      context 'when user2 is nil' do
        let(:ally_id) { nil }
        it { expect(new_allies).to have(1).error_on(:ally_id) }
      end
    end
  end

  context 'when destroying' do
    let(:subject) { allyship.destroy }
    let!(:user) { create(:user1) }
    let!(:ally) { create(:user2) }
    let(:allyship) { Allyship.where(user_id: user.id, ally_id: ally.id)[0] }

    before do
      Allyship.create(user_id: user.id, ally_id: ally.id, status: 'accepted')
      Allyship.create(user_id: ally.id, ally_id: user.id, status: 'accepted')
    end

    it { expect { subject }.to change { Allyship.count }.from(3).to(0) }

    context 'with viewer' do
      before do
        create_moment(user, ally)
        create_moment(ally, user)
        create_strategy(user, ally)
        create_strategy(ally, user)
      end

      it 'deletes viewer' do
        expect { subject }
          .to change { user.moments.first.viewers.count }.from(1).to(0)
          .and change { user.strategies.first.viewers.count }.from(1).to(0)
      end
    end

    context 'with allyship request notifications' do
      before do
        Notification.import(
          [
            build(:notification, user: user, uniqueid: "new_ally_request_#{ally.id}"),
            build(:notification, user: user, uniqueid: "accepted_ally_request_#{ally.id}"),
            build(:notification, user: ally, uniqueid: "new_ally_request_#{user.id}"),
            build(:notification, user: ally, uniqueid: "accepted_ally_request_#{user.id}"),
            build(:notification, user: user, uniqueid: "new_ally_request_#{ally.id + 10}"),
            build(:notification, user: ally, uniqueid: "new_ally_request_#{user.id + 10}")
          ]
        )
      end

      it { expect { subject }.to change { Notification.count }.from(6).to(2) }
    end

    def create_moment(user, viewer)
      Moment.create(
        category: [1],
        name: 'Presentation for ENGL 101',
        mood: [1, 2],
        why: 'I am presenting in front of' \
        'my classmates and I am worried I' \
        ' will make a fool out of myself',
        comment: true,
        user_id: user.id,
        viewers: [viewer.id]
      )
    end

    def create_strategy(user, viewer)
      Strategy.create(
        category: [1],
        name: 'I am a name!',
        description: 'I am a description!',
        comment: true,
        user_id: user.id,
        viewers: [viewer.id]
      )
    end
  end
end
