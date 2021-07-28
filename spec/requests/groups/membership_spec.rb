# frozen_string_literal: true

RSpec.describe 'Membership', type: :request do
  before { sign_in current_user }

  let(:current_user) { create(:user1) }

  describe '#create' do
    context 'new group member for existing group' do
      it 'adds new member' do
        # Arrange
        leader_user = create :user2
        group_leader = create :group_member, user_id: leader_user.id, leader: true
        group = group_leader.group

        # Act
        post group_membership_path(group_id: group.id)

        # Assert
        expect(response).to redirect_to(group_path(group))
        expect(flash[:notice]).to eq(
          'You have joined this group.'
        )
      end
    end

    context 'new group member for non-existent group' do
      it "doesn't new member" do
        # Act
        post group_membership_path(group_id: 9000)

        # Assert
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          "You cannot join a group that doesn't exist."
        )
      end
    end
  end

  describe '#kick' do
    context 'when current_user is a leader' do
      it 'can kick another group member out' do
        # Arrange
        group_leader = create :group_member, user_id: current_user.id, leader: true
        group = group_leader.group
        another_user = create :user2
        another_member = create :group_member, user_id: another_user.id, leader: false, group: group

        # Act
        delete kick_group_membership_path(group_id: group.id, member_id: another_user.id)

        # Assert
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have removed #{another_user.name} from #{group.name}"
        )
      end
    end

    context 'when current_user is not a leader' do
      it 'cannot kick another group member out' do
        # Arrange
        group_member = create :group_member, user_id: current_user.id, leader: false
        group = group_member.group
        another_user = create :user2
        another_member = create :group_member, user_id: another_user.id, leader: false, group: group

        # Act
        delete kick_group_membership_path(group_id: group.id, member_id: another_user.id)

        # Assert
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot remove a group member because you are not a leader.'
        )
      end
    end
  end

  describe '#leave' do
    context 'when current_user is not a leader' do
      it 'can leave group' do
        # Arrange
        leader_user = create :user2
        leader_member = create :group_member, user_id: leader_user.id, leader: true
        another_member = create :group_member, user_id: current_user.id, leader: false
        group = another_member.group

        # Act
        delete group_membership_path(group_id: group.id)

        # Assert
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have left #{group.name}"
        )
      end
    end

    context 'when current_user is a leader' do
      let(:group_member) { create :group_member, user_id: current_user.id, leader: true }

      it 'can leave the group when user is not the only leader' do
        # Arrange
        group = group_member.group
        another_user = create :user2
        another_member = create :group_member, user_id: another_user.id, leader: true, group: group

        # Act
        delete group_membership_path(group_id: group.id)

        # Assert
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have left #{group.name}"
        )
      end

      it 'cannot leave the group when user is the only leader' do
        # Act
        delete group_membership_path(group_id: group_member.group.id)

        # Assert
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot leave the group, you are the only leader.'
        )
      end
    end
  end
end
