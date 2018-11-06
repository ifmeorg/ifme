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
  it 'creates a valid ally relationship with accepted status' do
    new_user1 = create(:user1)
    new_user2 = create(:user2)
    new_allies = create(:allyships_accepted, user_id: new_user1.id, ally_id: new_user2.id)
    expect(Allyship.count).to eq(2)
  end

  it 'creates a valid ally relationship with pending_from_user_id1 status' do
    new_user1 = create(:user1)
    new_user2 = create(:user2)
    new_allies = create(:allyships_pending_from_user_id1, user_id: new_user1.id, ally_id: new_user2.id)
    expect(Allyship.count).to eq(2)
  end

  it 'creates a valid ally relationship with pending_from_user_id2 status' do
    new_user1 = create(:user1)
    new_user2 = create(:user2)
    new_allies = create(:allyships_pending_from_user_id2, user_id: new_user1.id, ally_id: new_user2.id)
    expect(Allyship.count).to eq(2)
  end

  it 'creates an invalid ally relationship where users are identical' do
    new_user1 = create(:user1)
    new_allies = build(:allyships_accepted, user_id: new_user1.id, ally_id: new_user1.id)
    expect(new_allies).to have(1).error_on(:user_id)
  end

  it 'creates an invalid ally relationship where user1 is nil' do
    new_user2 = create(:user2)
    new_allies = build(:allyships_accepted, user_id: nil, ally_id: new_user2.id)
    expect(new_allies).to have(1).error_on(:user_id)
  end

  it 'creates an invalid ally relationship where user2 is nil' do
    new_user1 = create(:user1)
    new_allies = build(:allyships_accepted, user_id: new_user1.id, ally_id: nil)
    expect(new_allies).to have(1).error_on(:ally_id)
  end

  context 'when destroying' do
    describe 'deletes pertinent allyship' do
      let!(:user) { create(:user1) }
      let!(:ally) { create(:user2) }

      before do
        Allyship.create(user_id: user.id,
                        ally_id: ally.id,
                        status: 'accepted')
        Allyship.create(user_id: ally.id,
                        ally_id: user.id,
                        status: 'accepted')
      end

      it 'deletes the allyship' do
        allyship_expected = Allyship.where(user_id: user.id,
                                           ally_id: ally.id)[0]
        expect { allyship_expected.destroy }
          .to change { Allyship.count }
      end
    end
  end

  context 'when destroying' do
    describe 'deletes pertinent viewer' do
      let!(:user) { create(:user1) }
      let!(:ally) { create(:user2) }

      before do
        Allyship.create(user_id: user.id,
                        ally_id: ally.id,
                        status: 'accepted')
        Allyship.create(user_id: ally.id,
                        ally_id: user.id,
                        status: 'accepted')

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
        allyship_expected = Allyship.where(user_id: user.id,
                                           ally_id: ally.id)[0]
        moment_expected = user.moments.first
        strategy_expected = user.strategies.first

        expect { allyship_expected.destroy }
          .to change { user.moments.first.viewers.count }.from(1).to(0)
                                                         .and change { user.strategies.first.viewers.count }.from(1).to(0)
      end
    end
  end

  context 'when destroying' do
    describe 'deletes pertinent allyship request notifications' do
      let!(:user) { create(:user1) }
      let!(:ally) { create(:user2) }

      before do
        Allyship.create(user_id: user.id,
                        ally_id: ally.id,
                        status: 'accepted')
        Allyship.create(user_id: ally.id,
                        ally_id: user.id,
                        status: 'accepted')

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
        allyship_expected = Allyship.find_by(user_id: user.id)
        expect { allyship_expected.destroy }
          .to change { Notification.count }
          .from(6).to(2)
      end
    end
  end
end
