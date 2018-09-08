RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    it 'respond to request' do
      get :home
      expect(response).to be_success
    end

    context 'logged in' do
      let(:user) { create(:user) }
      include_context :logged_in_user

      it 'if has no stories' do
        list = double
        expect(Kaminari).to receive(:paginate_array).and_return(list)
        expect(list).to receive(:page)
        get :home
      end

      it 'if have stories' do
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
          contain_exactly('link', 'link_name', 'author')
        )
        blurbs_file = File.read('doc/pages/blurbs.json')
        expect(assigns(:blurbs)).to eq(JSON.parse(blurbs_file))
      end
    end
  end

  describe 'GET #blog' do
    it 'respond to request' do
      get :blog
      expect(response).to be_success
    end

    it 'has posts' do
      get :blog
      expect(assigns(:posts)[0].keys).to(
        contain_exactly('link', 'link_name', 'author')
      )
    end
  end

  describe 'GET #contribute' do
    it 'respond to request' do
      get :contribute
      expect(response).to be_success
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

  describe 'GET #partners' do
    it 'respond to request' do
      get :partners
      expect(response).to be_success
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
      expect(response).to be_success
    end
  end

  describe 'GET #faq' do
    it 'respond to request' do
      get :faq
      expect(response).to be_success
    end
  end

  describe 'GET #privacy' do
    it 'respond to request' do
      get :privacy
      expect(response).to be_success
    end
  end

  describe 'GET #toggle_locale' do
    context 'When user is signed in' do
      let(:user) { create(:user) }
      include_context :logged_in_user

      it 'returns signed_in_reload object' do
        user.update!(locale: 'en')
        get :toggle_locale, params: { locale: 'es' }
        expect(JSON.parse(response.body)).to eq('signed_in_reload' => 'es')
      end

      it 'returns signed_in_no_reload object' do
        user.update!(locale: 'en')
        get :toggle_locale, params: { locale: 'en' }
        expect(JSON.parse(response.body)).to eq('signed_in_no_reload' => 'en')
      end
    end

    context 'When not signed in' do
      it 'returns signed_out object' do
        get :toggle_locale, params: { locale: 'es' }
        expect(JSON.parse(response.body)).to eq('signed_out' => true)
      end
    end
  end

  describe 'GET #resources' do
    it 'respond to request' do
      get :resources
      expect(response).to be_success
    end
  end
end
