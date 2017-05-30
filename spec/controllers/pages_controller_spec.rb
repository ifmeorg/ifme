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
        create(:strategy, userid: user.id)
        categories = create_list(:category, 2, userid: user.id)
        moods = create_list(:mood, 2, userid: user.id)

        get :home

        expect(assigns(:moment)).to be_a_new(Moment)
        expect(assigns(:categories)).to eq(categories.reverse)
        expect(assigns(:moods)).to eq(moods.reverse)
      end
    end

    context 'not logged in' do
      it 'has blurbs and posts' do
        get :home
        expect(assigns(:posts)[0].keys).to contain_exactly('link', 'link_name', 'author')
        blurbs_file = File.read('doc/contributors/blurbs.json')
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
      expect(assigns(:posts)[0].keys).to contain_exactly('link', 'link_name', 'author')
    end
  end

  describe 'GET #contributors' do
    it 'respond to request' do
      get :contributors

      expect(response).to be_success
    end

    it 'read external JSON file' do
      data = []
      blurbs_file = File.read('doc/contributors/blurbs.json')
      contributors_file = File.read('doc/contributors/contributors.json')

      expect(JSON).to receive(:parse).with(blurbs_file)
      expect(JSON).to receive(:parse).with(contributors_file).and_return(data)
      expect(data).to receive(:sort_by!)

      get :contributors
    end
  end

  describe 'GET #partners' do
    it 'respond to request' do
      get :partners

      expect(response).to be_success
    end

    it 'read external JSON file' do
      data = []
      file = File.read('doc/contributors/partners.json')

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

end
