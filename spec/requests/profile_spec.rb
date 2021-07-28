# frozen_string_literal: true

describe "Profile", type: :request do
  describe "#index" do
    context "when user is not logged in" do
      before { get profile_index_path, params: {uid: "user-id"} }
      it { expect(response).to redirect_to(new_user_session_path) }
    end

    context "when user is logged in" do
      let(:user) { create(:user1) }
      before { sign_in user }
      it "responds successfully" do
        get profile_index_path, params: {uid: user.uid}
        expect(response).to be_successful
      end

      context "when profile belongs to logged in user" do
        it "returns that users profile" do
          get profile_index_path, params: {uid: user.uid}
          expect(response.body).to include(user.name)
        end

        context "when user has no moments and strategies" do
          it "does not have the Stories section" do
            get profile_index_path, params: {uid: user.uid}
            expect(response.body).to_not include("Stories")
          end
        end

        context "when user has moments or strategies" do
          it "has the Stories section" do
            moment = create(:moment, user: user)
            strategy = create(:strategy, user: user)

            get profile_index_path, params: {uid: user.uid}
            expect(response.body).to include("Stories")
            expect(response.body).to include(moment.name)
            expect(response.body).to include(strategy.name)
          end
        end
      end

      context "when profile does not belong to user" do
        let(:profile_owner) { build_stubbed(:user2) }

        before do
          allow(User).to receive(:find_by).and_return(profile_owner)
          get profile_index_path, params: {uid: profile_owner.uid}
        end

        it "does not have the Stories section" do
          expect(response.body).to_not include("Stories")
        end

        it "returns the profile for the owner" do
          expect(response.body).to include(profile_owner.name)
        end
      end
    end
  end

  describe "#data" do
    let(:user) { create(:user) }
    let!(:moment) { create(:moment, user: user) }

    context "when the user is signed in" do
      before { sign_in user }
      before { get data_profile_index_path, params: {page: 1, uid: user.uid}, headers: {"ACCEPT" => "application/json"} }

      it "returns a response with the correct path" do
        expect(JSON.parse(response.body)["data"].first["link"]).to eq moment_path(moment)
      end
    end

    context "when the user is not signed in" do
      before { get data_profile_index_path params: {page: 1, uid: user.uid}, headers: {"ACCEPT" => "application/json"} }

      it "returns a no_content status" do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe "#add_ban" do
    let(:user) { create(:user2) }

    before(:each) { Devise.mailer.deliveries.clear }

    context "when signed in user is not an admin" do
      let(:non_admin_user) { create(:user1) }
      before { sign_in non_admin_user }

      it "cannot ban user" do
        post add_ban_profile_index_path, params: {user_id: user.id}
        expect(response).to have_http_status(204)
        expect(Devise.mailer.deliveries.count).to eq(0)
      end
    end

    context "when signed in user is an admin" do
      let(:admin_user) { create(:user1, admin: true) }
      before { sign_in admin_user }

      context "when user exists" do
        it "bans the user" do
          expect { post add_ban_profile_index_path, params: {user_id: user.id} }
            .to change(Devise.mailer.deliveries, :count).by 1
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:notice]).to eq("#{user.name} has been banned")
        end
      end

      context "when user does not exist" do
        it "does not ban the user" do
          expect { post add_ban_profile_index_path, params: {user_id: -1} }
            .not_to change(Devise.mailer.deliveries, :count).from(0)
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to eq("Could not ban -1")
        end
      end
    end
  end

  describe "#remove_ban" do
    let(:banned_user) { create(:user2, banned: true) }

    before(:each) { Devise.mailer.deliveries.clear }

    context "when signed in user is not an admin" do
      let(:nonadmin_user) { create(:user1) }
      before { sign_in nonadmin_user }

      it "cannot ban user" do
        expect { post remove_ban_profile_index_path, params: {user_id: banned_user.id} }
          .not_to change(Devise.mailer.deliveries, :count).from(0)
        expect(response).to have_http_status(204)
      end
    end

    context "when signed in user is an admin" do
      let(:admin_user) { create(:user1, admin: true) }
      before { sign_in admin_user }

      context "when user exists" do
        it "removes ban" do
          expect { post remove_ban_profile_index_path, params: {user_id: banned_user.id} }
            .to change(Devise.mailer.deliveries, :count).by(1)
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:notice]).to eq("Ban removed from #{banned_user.name}")
        end
      end

      context "when user does not exist" do
        it "does not remove ban" do
          expect { post remove_ban_profile_index_path, params: {user_id: -1} }
            .not_to change(Devise.mailer.deliveries, :count).from(0)
          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to include("Could not remove ban")
        end
      end
    end
  end
end
