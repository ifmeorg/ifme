# frozen_string_literal: true
# == Schema Information
#
# Table name: allyships
#
#  id         :bigint(8)        not null, primary key
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
    let(:new_user1) { create(:user1) }
    let(:new_user2) { create(:user2) }

    context 'with accepted status' do
      it 'creates a valid ally relationship' do
        create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)

        expect(Allyship.count).to eq 2
      end
    end

    context 'with pending_from_user_id1 status' do
      it 'creates a valid ally relationship' do
        create(:allyships_pending_from_user_id1, user_id: new_user1.id, ally_id: new_user2.id)

        expect(Allyship.count).to eq 2
      end
    end

    context 'with pending_from_user_id2 status' do
      it 'creates a valid ally relationship' do
        create(:allyships_pending_from_user_id2, user_id: new_user1.id, ally_id: new_user2.id)

        expect(Allyship.count).to eq 2
      end
    end

    context 'with invalid ally relationship' do
      context 'when users are identical' do
        it 'creates an invalid ally relationship' do
          new_allies = build(:allyships_accepted, user_id: new_user1.id, ally_id: new_user1.id)

          expect(new_allies).to have(1).error_on(:user_id)
        end
      end

      context 'when user1 is nil' do
        it 'creates an invalid ally relationship' do
          new_allies = build(:allyships_accepted, user_id: nil, ally_id: new_user2.id)

          expect(new_allies).to have(1).error_on(:user_id)
        end
      end

      context 'when user2 is nil' do
        it 'creates an invalid ally relationship' do
          new_allies = build(:allyships_accepted, user_id: new_user1.id, ally_id: nil)

          expect(new_allies).to have(1).error_on(:ally_id)
        end
      end
    end
  end

  context 'when destroying' do
    let!(:user) { create(:user1) }
    let!(:ally) { create(:user2) }
    let(:allyship) { Allyship.where(user_id: user.id, ally_id: ally.id)[0] }

    before do
      Allyship.create(user_id: user.id, ally_id: ally.id, status: 'accepted')
      Allyship.create(user_id: ally.id, ally_id: user.id, status: 'accepted')
    end

    it 'deletes the allyship' do
      expect { allyship.destroy }.to change { Allyship.count }
    end

    context 'with viewer' do
      before do
        Moment.create(category: [1],
                      name: 'Presentation for ENGL 101',
                      mood: [1, 2],
                      why: 'I am presenting in front of' \
                      'my classmates and I am worried I' \
                      ' will make a fool out of myself',
                      comment: true,
                      user_id: user.id,
                      viewers: [ally.id])

        Moment.create(category: [1],
                      name: 'Presentation for ENGL 101',
                      mood: [1, 2],
                      why: 'I am presenting in front of' \
                      'my classmates and I am worried I' \
                      ' will make a fool out of myself',
                      comment: true,
                      user_id: ally.id,
                      viewers: [user.id])

        Strategy.create(category: [1],
                        name: 'I am a name!',
                        description: 'I am a description!',
                        comment: true,
                        user_id: user.id,
                        viewers: [ally.id])

        Strategy.create(category: [1],
                        name: 'I am a name!',
                        description: 'I am a description!',
                        comment: true,
                        user_id: ally.id,
                        viewers: [user.id])
      end

      it 'deletes viewer' do
        expect { allyship.destroy }
          .to change { user.moments.first.viewers.count }.from(1).to(0)
          .and change { user.strategies.first.viewers.count }.from(1).to(0)
      end
    end

    context 'with allyship request notifications' do
      before do
        Notification.import([
                              build(
                                :notification,
                                user: user,
                                uniqueid: "new_ally_request_#{ally.id}"
                              ),
                              build(
                                :notification,
                                user: user,
                                uniqueid: "accepted_ally_request_#{ally.id}"
                              ),
                              build(
                                :notification,
                                user: ally,
                                uniqueid: "new_ally_request_#{user.id}"
                              ),
                              build(
                                :notification,
                                user: ally,
                                uniqueid: "accepted_ally_request_#{user.id}"
                              ),
                              build(
                                :notification,
                                user: user,
                                uniqueid: "new_ally_request_#{ally.id + 10}"
                              ),
                              build(
                                :notification,
                                user: ally,
                                uniqueid: "new_ally_request_#{user.id + 10}"
                              )
                            ])
      end

      it 'deletes the ally notifications' do
        expect { allyship.destroy }.to change { Notification.count }.from(6).to(2)
      end
    end
  end
end
