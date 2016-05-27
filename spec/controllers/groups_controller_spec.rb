require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do
  describe "GET #index" do
    it "assigns groups to the groups that the user belongs to" do
      user = create :user1
      sign_in user
      group = create :group
      other_group = create :group
      create :group_member, groupid: group.id, userid: user.id
      create :group_member, groupid: other_group.id

      get :index

      expect(assigns(:groups)).to eq [group]
    end
  end

  describe "GET #show" do
    context "when the group exists" do
      it "sets the group" do
        user = create :user1
        sign_in user
        group = create :group

        get :show, id: group.id

        expect(assigns(:group)).to eq(group)
      end

      context "when user is member of the group" do
        it "sets @is_group_member to true" do
          user = create :user1
          sign_in user
          group = create :group_with_member, userid: user.id

          get :show, id: group.id

          expect(assigns(:is_group_member)).to be true
        end

        it "sets @meetings to the group's meetings" do
          user = create :user1
          sign_in user
          group = create :group_with_member, userid: user.id
          meeting = create :meeting, groupid: group.id

          get :show, id: group.id

          expect(assigns(:meetings)).to eq [meeting]
        end
      end

      context "when user is not a member of the group" do
        it "sets @is_group_member to false" do
          user = create :user1
          sign_in user
          group = create :group

          get :show, id: group.id

          expect(assigns(:is_group_member)).to be false
        end
      end

      it "sets @group_leaders correctly" do
        user = create :user1
        sign_in user
        group = create :group
        leader = create :user2
        group_leader = create :group_leader, groupid: group.id, userid: leader.id

        get :show, id: group.id

        expect(assigns(:group_leaders)).to eq [group_leader]
      end
    end

    context "when group doesn't exist" do
      it "redirects to the index" do
        user = create :user1
        sign_in user

        get :show, id: 1

        expect(response).to redirect_to(groups_path)
      end
    end
  end
end
