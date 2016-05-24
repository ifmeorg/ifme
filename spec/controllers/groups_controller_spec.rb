require 'rails_helper'

RSpec.describe GroupsController, :type => :controller do
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
