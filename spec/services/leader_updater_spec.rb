require 'spec_helper'

describe LeaderUpdater, '#update' do
  it 'removes leaders whose ids are not passed in' do
    group = create :group
    leader = create :user1
    other_leader = create :user1
    create :group_member, group: group, userid: leader.id, leader: true
    create :group_member, group: group, userid: other_leader.id, leader: true
    notifier = double('notifier')
    expect(GroupNotifier).to receive(:new)
      .with(group, 'remove_group_leader', other_leader).and_return(notifier)
    expect(notifier).to receive(:send_notifications_to)
      .with([leader, other_leader])

    LeaderUpdater.new(group, [leader.id]).update

    expect(group.leaders).not_to include(other_leader)
  end

  it 'adds leaders whose ids are passed in' do
    group = create :group
    leader = create :user1
    non_leader = create :user1
    create :group_member, group: group, userid: leader.id, leader: true
    create :group_member, group: group, userid: non_leader.id, leader: false
    notifier = double('notifier')
    expect(GroupNotifier).to receive(:new)
      .with(group, 'add_group_leader', non_leader).and_return(notifier)
    expect(notifier).to receive(:send_notifications_to).with([leader])

    LeaderUpdater.new(group, [leader.id, non_leader.id]).update

    expect(group.leaders).to include(non_leader)
  end
end
