# frozen_string_literal: true

describe "Pages", type: :request do
  let(:user) { create(:user) }

  describe "#home" do
    let(:medium_posts) do
      [{ 'title' => 'Test Post', 'link' => 'https://medium.com/ifme/test', 'author' => 'Test Author' }]
    end

    before do
      allow_any_instance_of(Medium).to receive(:posts).and_return(medium_posts)
    end

    it "respond to request" do
      get pages_home_path
      expect(response).to be_successful
    end

    context "logged in" do
      before { sign_in user }

      context "with recent unacknowledged crisis moments" do
        before do
          create(:moment, user: user,
                          why: 'I have been feeling suicidal.',
                          crisis_prevention_acknowledged: false,
                          created_at: 1.week.ago)
        end

        it "sets show_crisis_prevention_index to true" do
          get pages_home_path
          expect(assigns(:show_crisis_prevention_index)).to be true
        end
      end

      context "without recent unacknowledged crisis moments" do
        it "sets show_crisis_prevention_index to false" do
          get pages_home_path
          expect(assigns(:show_crisis_prevention_index)).to be false
        end
      end

      context "when recent moments are already acknowledged" do
        before do
          create(:moment, user: user,
                          why: 'I have been feeling suicidal.',
                          crisis_prevention_acknowledged: true,
                          created_at: 1.week.ago)
        end

        it "sets show_crisis_prevention_index to false" do
          get pages_home_path
          expect(assigns(:show_crisis_prevention_index)).to be false
        end
      end

      context "when crisis moments are older than one month" do
        before do
          create(:moment, user: user,
                          why: 'I have been feeling suicidal.',
                          crisis_prevention_acknowledged: false,
                          created_at: 6.weeks.ago)
        end

        it "sets show_crisis_prevention_index to false" do
          get pages_home_path
          expect(assigns(:show_crisis_prevention_index)).to be false
        end
      end

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

        expect(assigns(:posts).first.keys).to contain_exactly(:link, :link_name, :author)
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

  describe "public moment approval" do
    let(:author) { create(:user1) }
    let(:admin) { create(:user2, admin: true) }
    let(:pending_moment) do
      create(:moment, :with_published_at,
             user: author, name: "Pending Story", make_public: true)
    end

    describe "#admin_dashboard" do
      before { sign_in admin }

      it "lists a moment awaiting approval with its approve link" do
        pending_moment

        get admin_dashboard_path

        expect(response).to be_successful
        expect(assigns(:pending_moments)).to contain_exactly(pending_moment)
        expect(response.body).to include("Pending Story")
        expect(response.body)
          .to include(approve_public_moment_path(moment_id: pending_moment.id))
      end

      it "leaves out private and already approved moments" do
        create(:moment, :with_published_at, user: author)
        create(:moment, :with_published_at,
               user: author, make_public: true,
               public_approved_at: Time.zone.now)

        get admin_dashboard_path

        expect(assigns(:pending_moments)).to be_empty
        expect(response.body).to include("No Moments Awaiting Public Approval")
      end

      it "leaves out unpublished drafts" do
        create(:moment, user: author, make_public: true)

        get admin_dashboard_path

        expect(assigns(:pending_moments)).to be_empty
      end

      it "lists the newest moment first" do
        older = create(:moment, :with_published_at,
                       user: author, make_public: true, created_at: 2.days.ago)
        newer = pending_moment

        get admin_dashboard_path

        expect(assigns(:pending_moments).to_a).to eq([newer, older])
      end
    end

    describe "#approve_public_moment" do
      def approve(id)
        post approve_public_moment_path(moment_id: id)
      end

      context "when not signed in" do
        it "redirects to sign in without approving" do
          approve(pending_moment.id)

          expect(response).to redirect_to(new_user_session_path)
          expect(pending_moment.reload.public_approved_at).to be_nil
        end
      end

      context "when signed in as a non-admin" do
        it "does not let the author approve their own moment" do
          sign_in author

          approve(pending_moment.id)

          expect(response).to redirect_to("/")
          expect(pending_moment.reload.public_approved_at).to be_nil
        end
      end

      context "when signed in as an admin" do
        before { sign_in admin }

        it "approves a pending moment" do
          approve(pending_moment.id)

          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:notice]).to eq("Moment approved for the public page")
          expect(pending_moment.reload.public_approved_at).to be_present
        end

        it "removes the approved moment from the pending list" do
          approve(pending_moment.id)

          get admin_dashboard_path

          expect(assigns(:pending_moments)).to be_empty
        end

        it "does not approve a moment that was not requested to be public" do
          private_moment = create(:moment, :with_published_at, user: author)

          approve(private_moment.id)

          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to eq("Could not approve this moment")
          expect(private_moment.reload.public_approved_at).to be_nil
        end

        it "does not approve an unpublished draft" do
          draft = create(:moment, user: author, make_public: true)

          approve(draft.id)

          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to eq("Could not approve this moment")
          expect(draft.reload.public_approved_at).to be_nil
        end

        it "does not overwrite the date of an approved moment" do
          approved_at = 3.days.ago.change(usec: 0)
          approved = create(:moment, :with_published_at,
                            user: author, make_public: true,
                            public_approved_at: approved_at)

          approve(approved.id)

          expect(flash[:alert]).to eq("Could not approve this moment")
          expect(approved.reload.public_approved_at).to eq(approved_at)
        end

        it "shows an error for a moment that does not exist" do
          approve(-1)

          expect(response).to redirect_to(admin_dashboard_path)
          expect(flash[:alert]).to eq("Could not approve this moment")
        end
      end
    end
  end
end
