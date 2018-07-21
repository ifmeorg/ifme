RSpec.describe Groups::MembershipsController, type: :controller do
  include StubCurrentUserHelper

  describe 'DELETE #kick' do
    context 'when current_user is a leader' do
      it 'can kick another group member out' do
        create_current_user
        group_member = create :group_member, user_id: controller.current_user.id,
                                             leader: true
        group = group_member.group
        another_user = create :user2
        another_member = create :group_member, user_id: another_user.id,
                                              leader: false,
                                              group: group
        delete :kick, params: {
          group_id: group_member.group.id,
          member_id: another_user.id
        }
        expect(response).to redirect_to(groups_path)
        expect(flash[:notice]).to eq(
          "You have removed #{another_user.name} from #{group.name}"
        )
      end
    end

    context 'when current_user is not a leader' do
      it 'cannot kick another group member out' do
        # Setup steps
        # FactoryBot / FactoryGirl
        create_current_user
        group_member = create :group_member, user_id: controller.current_user.id,
                                             leader: false
        group = group_member.group
        another_user = create :user2
        another_member = create :group_member, user_id: another_user.id,
                                               leader: false,
                                               group: group

        # Action taken
        delete :kick, params: {
          group_id: group_member.group.id,
          member_id: another_member.user_id
        }

        # What I expect to happen (assertion/expectation)
        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot kick a group member because you are not a leader.'
        )
      end
    end
  end

  describe 'DELETE #leave' do
    context 'when current_user is the only leader of the group' do
      it 'cannot leave the group' do
        create_current_user
        group_member = create :group_member, user_id: controller.current_user.id,
                                             leader: true

        delete :destroy, params: { group_id: group_member.group.id }

        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot leave the group, you are the only leader.'
        )
      end
    end
  end
end
