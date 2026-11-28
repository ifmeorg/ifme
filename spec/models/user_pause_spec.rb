# frozen_string_literal: true

describe User, 'pausing' do
  let(:user) { create(:user1) }
  let(:ally) { create(:user2) }

  it 'is not paused by default' do
    expect(user).not_to be_paused
  end

  it 'can be paused and resumed' do
    user.pause!
    expect(user.reload).to be_paused

    user.resume!
    expect(user.reload).not_to be_paused
  end

  it 'can still sign in while paused, in order to resume' do
    user.pause!
    expect(user.active_for_authentication?).to be true
  end

  it 'is hidden from allies while paused and restored afterwards' do
    create(:allyships_accepted, user: user, ally: ally)
    # The factory only accepts one side; real allies have both accepted.
    Allyship.where(user: ally, ally: user)
            .update_all(status: Allyship.statuses[:accepted])
    expect(ally.reload.mutual_allies?(user)).to be true

    user.pause!
    expect(ally.reload.allies_by_status(:accepted)).to be_empty
    expect(ally.mutual_allies?(user)).to be false

    user.resume!
    expect(ally.reload.allies_by_status(:accepted)).to contain_exactly(user)
    expect(ally.mutual_allies?(user.reload)).to be true
  end

  it 'cancels pending ally requests in both directions' do
    Allyship.create!(user: user, ally: ally, status: :pending_from_ally)

    user.pause!

    expect(Allyship.where(user: [user, ally])).to be_empty
  end
end
