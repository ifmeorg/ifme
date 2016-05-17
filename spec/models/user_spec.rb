require 'spec_helper'

describe User do
  describe ".find_for_google_oauth2" do
    let(:access_token) { 
      double({ 
                info: double({ email: "some@user.com", name: "some name" }),
                provider: "asdf",
                credentials: double({ token: "some token" }),
                uid: "some uid"
      })
    }

    context "an existing user" do
      let!(:user) { User.create(email: "some@user.com", password: "asdfasdf") }

      it "updates token information" do
        User.find_for_google_oauth2(access_token)
        user.reload
        expect(user.provider).to eq("asdf")
        expect(user.token).to eq("some token")
        expect(user.uid).to eq("some uid")
      end

      it "returns a user" do
        expect(User.find_for_google_oauth2(access_token)).to eq(user.reload)
      end
    end

    context "a new user" do
      it "creates a new user" do
        expect(User.where(email: "some@user.com").first).to be_nil
        User.find_for_google_oauth2(access_token)
        expect(User.where(email: "some@user.com").first).to be_a_kind_of(User)
      end

      it "returns a user" do
        expect(User.find_for_google_oauth2(access_token)).to be_a_kind_of(User)
      end
    end
  end  
end