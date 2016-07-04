require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do
  include StubCurrentUserHelper

  describe "GET #index" do
    it "assigns groups to the groups that the user belongs to" do
      stub_current_user
      group = create :group_with_member, userid: controller.current_user.id
      other_user = build_stubbed(:user2)
      create :group_with_member, userid: other_user.id

      get :index

      expect(assigns(:groups)).to eq [group]
    end

    context "when user isn't signed in" do
      it "redirects to the sign in page" do
        get :index

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "when the group exists" do
      let(:group) { create :group }

      it "sets the group" do
        stub_current_user

        get :show, id: group.id

        expect(assigns(:group)).to eq(group)
      end

      context "when user is member of the group" do
        it "sets @meetings to the group's meetings" do
          create_current_user
          group = create :group_with_member, userid: controller.current_user.id
          meeting = create :meeting, groupid: group.id

          get :show, id: group.id

          expect(assigns(:meetings)).to eq [meeting]
        end
      end
    end

    context "when group doesn't exist" do
      it "redirects to the index" do
        stub_current_user
        get :show, id: 999

        expect(response).to redirect_to(groups_path)
      end
    end

    context "when user isn't signed in" do
      it "redirects to sign in" do
        get :show, id: 999

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #leave" do
    context "when current_user is the only leader of the group" do
      it "redirects to groups_path with alert message" do
        create_current_user
        group_member = create :group_member, userid: controller.current_user.id,
                                             leader: true

        get :leave, groupid: group_member.group.id

        expect(response).to redirect_to(groups_path)
        expect(flash[:alert]).to eq(
          'You cannot leave the group, you are the only leader.'
        )
      end
    end
  end

  describe 'GET #update' do
    it 'updates leader' do
      stub_current_user
      group = create :group
      user = create :user
      non_leader = create :group_member, group: group, leader: false, user: user

      put :update, id: group.id, group: { leader: [user.id] }

      non_leader.reload
      expect(non_leader.leader).to be true
    end
  end
end
