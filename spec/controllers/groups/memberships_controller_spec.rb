# frozen_string_literal: true

RSpec.describe Groups::MembershipsController, type: :controller do
  include StubCurrentUserHelper

  before do
    create_current_user
  end

  describe '#create' do
    context 'new group member for existing group' do
      let!(:leader_user) { create :user2 }
      let!(:group_leader) { create :group_member, user_id: leader_user.id, leader: true }
      let!(:group) { group_leader.group }

      it 'adds new member' do
        post :create, params: {
          group_id: group.id
        }
        expect(response).to redirect_to(group_path(group))
        expect(flash[:notice]).to eq(
          'You have joined this group.'
        )
      end
    end

    context 'new group member for non-existent group' do
      it "doesn't new member" do
        post :create, params: {
          group_id: 9000
        }
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          "You cannot join a group that doesn't exist."
        )
      end
    end
  end

  describe '#kick' do
    context 'when current_user is a leader' do
      let!(:group_leader) { create :group_member, user_id: controller.current_user.id, leader: true }
      let!(:group) { group_leader.group }
      let!(:another_user) { create :user2 }
      let!(:another_member) { create :group_member, user_id: another_user.id, leader: false, group: group }

      it 'can kick another group member out' do
        delete :kick, params: {
          group_id: group.id,
          member_id: another_user.id
        }
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have removed #{another_user.name} from #{group.name}"
        )
      end
    end

    context 'when current_user is not a leader' do
      let!(:group_member) { create :group_member, user_id: controller.current_user.id, leader: false }
      let!(:group) { group_member.group }
      let!(:another_user) { create :user2 }
      let!(:another_member) { create :group_member, user_id: another_user.id, leader: false, group: group }

      it 'cannot kick another group member out' do
        delete :kick, params: {
          group_id: group.id,
          member_id: another_user.id
        }
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot kick a group member because you are not a leader.'
        )
      end
    end
  end

  describe '#leave' do
    context 'when current_user is not a leader' do
      let!(:leader_user) { create :user2 }
      let!(:leader_member) { create :group_member, user_id: leader_user.id, leader: true }
      let!(:another_member) { create :group_member, user_id: controller.current_user.id, leader: false }
      let!(:group) { another_member.group }

      it 'can leave group' do
        delete :destroy, params: { group_id: group.id }
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have left #{group.name}"
        )
      end
    end

    context 'when current_user is a leader' do
      let!(:group_member) { create :group_member, user_id: controller.current_user.id, leader: true }

      it 'can leave the group when user is not the only leader' do
        group = group_member.group
        another_user = create :user2
        another_member = create :group_member, user_id: another_user.id, leader: true, group: group
        delete :destroy, params: { group_id: group.id }
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have left #{group.name}"
        )
      end

      it 'cannot leave the group when user is the only leader' do
        delete :destroy, params: { group_id: group_member.group.id }
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot leave the group, you are the only leader.'
        )
      end
    end
  end
end
