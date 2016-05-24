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
