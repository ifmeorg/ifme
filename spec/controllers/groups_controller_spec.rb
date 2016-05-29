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
end
