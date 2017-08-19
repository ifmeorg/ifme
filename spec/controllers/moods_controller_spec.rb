RSpec.describe MoodsController, type: :controller do
  let(:user) { create(:user1) }

  context "user is not signed in" do
    subject { get :index }
    it "redirects to sign in page" do
      expect(subject).to redirect_to new_user_session_url
    end
  end

  context "user is signed in" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "renders the page" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end
