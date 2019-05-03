# frozen_string_literal: true

describe PagesController, type: :controller do
  describe 'GET #home' do
    it 'respond to request' do
      get :home
      expect(response).to be_successful
    end

    context 'logged in' do
      let(:user) { create(:user) }
      include_context :logged_in_user

      it 'has no stories' do
        list = double
        expect(Kaminari).to receive(:paginate_array).and_return(list)
        expect(list).to receive(:page)
        get :home
      end

      it 'has stories' do
        create(:strategy, user_id: user.id)
        categories = create_list(:category, 2, user_id: user.id)
        moods = create_list(:mood, 2, user_id: user.id)
        get :home
        expect(assigns(:moment)).to be_a_new(Moment)
        expect(assigns(:categories)).to eq(categories.reverse)
        expect(assigns(:moods)).to eq(moods.reverse)
      end
    end

    context 'not logged in' do
      it 'has blurbs and posts' do
        get :home
        expect(assigns(:posts)[0].keys).to(
          contain_exactly(:link, :link_name, :author)
        )
        blurbs_file = File.read('doc/pages/blurbs.json')
        expect(assigns(:blurbs)).to eq(JSON.parse(blurbs_file))
      end
    end
  end

  describe 'GET #contribute' do
    it 'respond to request' do
      get :contribute
      expect(response).to be_successful
    end

    it 'read external JSON file' do
      data = []
      blurbs_file = File.read('doc/pages/blurbs.json')
      contributors_file = File.read('doc/pages/contributors.json')
      expect(JSON).to receive(:parse).with(blurbs_file)
      expect(JSON).to receive(:parse).with(contributors_file).and_return(data)
      expect(data).to receive(:sort_by!)
      get :contribute
    end
  end

  describe 'GET #home_data' do
    let(:user) { create(:user) }
    let(:moment) { create(:moment, user: user) }
    include_context :logged_in_user
    before { get :home_data, params: { page: 1, id: moment.id }, format: :json }

    it 'returns a response with the correct path' do
      expect(JSON.parse(response.body)['data'].first['link']).to eq moment_path(moment)
    end
  end

  describe 'GET #partners' do
    it 'respond to request' do
      get :partners
      expect(response).to be_successful
    end

    it 'read external JSON file' do
      data = []
      file = File.read('doc/pages/partners.json')
      expect(JSON).to receive(:parse).with(file).and_return(data)
      expect(data).to receive(:sort_by!)
      get :partners
    end
  end

  describe 'GET #about' do
    it 'respond to request' do
      get :about
      expect(response).to be_successful
    end
  end

  describe 'GET #faq' do
    it 'respond to request' do
      get :faq
      expect(response).to be_successful
    end
  end

  describe 'GET #privacy' do
    it 'respond to request' do
      get :privacy
      expect(response).to be_successful
    end
  end

  describe 'POST #toggle_locale' do
    context 'When user is signed in' do
      let(:user) { build(:user) }
      include_context :logged_in_user

      it 'has a 200 status when the locale changes' do
        user.update!(locale: 'en')
        post :toggle_locale, params: { locale: 'es' }
        expect(user.locale).to eq('es')
        expect(response.status).to eq(200)
      end

      it 'has a 400 status when the locale is the same' do
        user.update!(locale: 'en')
        post :toggle_locale, params: { locale: 'en' }
        expect(user.locale).to eq('en')
        expect(response.status).to eq(400)
      end
    end

    context 'When not signed in' do
      it 'has a 200 status' do
        post :toggle_locale, params: { locale: 'es' }
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET #resources' do
    describe 'when sending filter params' do
      it 'filters the aforementioned resources' do
        get :resources, params: { filter: %w[ADD english] }

        expect(assigns(:keywords)).to match_array(%w[ADD English])
      end

      it 'filters only existing resources' do
        get :resources, params: { filter: %w[ADD someUnexistentTag] }

        expect(assigns(:keywords)).to match_array(['ADD'])
      end
    end

    it 'respond to request' do
      get :resources
      expect(response).to be_successful
    end
  end
end
