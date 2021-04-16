# frozen_string_literal: true

describe "Pages", type: :request do
  let(:user) { create(:user) }

  describe "#home" do
    it "respond to request" do
      get pages_home_path
      expect(response).to be_successful
    end

    context "logged in" do
      before { sign_in user }

      it "has no stories" do
        list = double
        allow(Kaminari).to receive(:paginate_array).and_return(list)
        allow(list).to receive(:page)

        get pages_home_path

        expect(Kaminari).to have_received(:paginate_array)
        expect(list).to have_received(:page)
      end

      it "has stories" do
        create(:strategy, user_id: user.id)
        categories = create_list(:category, 2, user_id: user.id)
        moods = create_list(:mood, 2, user_id: user.id)

        get pages_home_path

        expect(assigns(:moment)).to be_a_new(Moment)
        expect(assigns(:categories)).to eq(categories.reverse)
        expect(assigns(:moods)).to eq(moods.reverse)
      end
    end

    context "not logged in" do
      it "has blurbs and posts" do
        get pages_home_path

        expect(assigns(:posts)[0].keys).to contain_exactly(:link, :link_name, :author)
        blurbs_file = File.read("doc/pages/blurbs.json")
        expect(assigns(:blurbs)).to eq(JSON.parse(blurbs_file))
      end
    end
  end

  describe "#home_data" do
    context "when the user is logged in" do
      it "returns a response with the correct path" do
        moment = create(:moment, user: user)
        sign_in user
        get home_data_path, params: {page: 1}, headers: {"ACCEPT" => "application/json"}
        expect(JSON.parse(response.body)["data"].first["link"]).to eq moment_path(moment)
      end
    end

    context "when the user is not logged in" do
      it "returns a no_content status" do
        get home_data_path, params: {page: 1}, headers: {"ACCEPT" => "application/json"}
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe "#partners" do
    it "respond to request" do
      get partners_path
      expect(response).to be_successful
    end

    it "read external JSON file" do
      data = []
      file = File.read("doc/pages/partners.json")
      allow(JSON).to receive(:parse).with(file).and_return(data)
      allow(data).to receive(:sort_by!)

      get partners_path

      expect(JSON).to have_received(:parse).with(file)
      expect(data).to have_received(:sort_by!)
    end
  end

  describe "#about" do
    it "respond to request" do
      get about_path
      expect(response).to be_successful
    end

    it "read external JSON file" do
      data = []
      blurbs_file = File.read("doc/pages/blurbs.json")
      contributors_file = File.read("doc/pages/contributors.json")
      allow(JSON).to receive(:parse).with(blurbs_file)
      allow(JSON).to receive(:parse).with(contributors_file).and_return(data)
      allow(data).to receive(:sort_by!)

      get about_path

      expect(JSON).to have_received(:parse).with(blurbs_file)
      expect(JSON).to have_received(:parse).with(contributors_file)
      expect(data).to have_received(:sort_by!)
    end
  end

  describe "#faq" do
    it "respond to request" do
      get faq_path
      expect(response).to be_successful
    end
  end

  describe "#privacy" do
    it "respond to request" do
      get privacy_path
      expect(response).to be_successful
    end
  end

  describe "#toggle_locale" do
    context "When user is signed in" do
      let(:user) { build(:user, locale: "en") }
      before { sign_in user }

      it "has a 200 status when the locale changes" do
        post toggle_locale_path, params: {locale: "es"}
        expect(user.locale).to eq("es")
        expect(response).to have_http_status(200)
      end

      it "has a 400 status when the locale is the same" do
        post toggle_locale_path, params: {locale: "en"}
        expect(user.locale).to eq("en")
        expect(response).to have_http_status(400)
      end
    end

    context "when not signed in" do
      it "has a 200 status" do
        post toggle_locale_path, params: {locale: "es"}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#resources" do
    context "when sending filter params" do
      it "filters the aforementioned resources" do
        get resources_path, params: {filter: %w[ADD english]}

        expect(assigns(:keywords)).to match_array(%w[ADD English])
      end

      it "filters only existing resources" do
        get resources_path, params: {filter: %w[ADD someUnexistentTag]}

        expect(assigns(:keywords)).to match_array(['ADD'])
      end
    end

    it "respond to request" do
      get resources_path
      expect(response).to be_successful
    end
  end
end