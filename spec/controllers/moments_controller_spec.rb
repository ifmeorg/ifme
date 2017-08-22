describe MomentsController do
  describe "signed in" do
    it "GET index" do
      new_user = create(:user1)
      sign_in new_user
      get :index
      expect(response).to render_template(:index)
    end

    it "POST new" do
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      new_moment = attributes_for(:moment).merge(userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id))
      get :new
      expect(response).to render_template(:new)
      expect{post :create,  moment: new_moment}.to change(Moment, :count).by(1)
    end

    it "GET show" do
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      new_strategies = create(:strategy, userid: new_user.id)
      new_moment = create(:moment, userid: new_user.id, category: Array.new(1, new_category.id), mood: Array.new(1, new_mood.id), strategy: Array.new(1, new_strategies.id))
      get :show, id: new_moment
      expect(response).to render_template(:show)
    end
  end

  describe 'POST comment' do
    let(:user)          { create(:user, id: 1) }
    let!(:new_moment)    { create(:moment, id: 1, userid: 1) }
    let(:valid_comment_params) { attributes_for(:comment).merge(comment_by: 1, commented_on: 1, visibility: 'all') }
    let(:invalid_comment_params) { attributes_for(:comment, commented_on: 1)}

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment is saved' do
        it 'responds with an OK status' do
          post :comment, valid_comment_params

          expect(response.status).to eq(200)
        end
      end

      context 'when the comment is not saved' do
        it 'responds with json no_save: true' do
          post :comment, invalid_comment_params

          expect(response.body).to eq({no_save: true}.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        post :comment
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET delete_comment' do
    let(:user)          { create(:user, id: 1) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment exists and belongs to the current_user' do
        let!(:new_moment)    { create(:moment, id: 1, userid: 1) }
        let!(:comment)       { create(:comment, id: 1, comment_by: 1, commented_on: 1, visibility: 'all') }

        it 'destroys the comment' do
          expect { get :delete_comment, commentid: 1 }.to change(Comment, :count).by(-1)
        end

        it 'renders nothing' do
          get :delete_comment, commentid: 1

          expect(response.body).to eq("")
        end
      end

      context 'when the comment exists and the strategy belongs to the current_user' do
        let!(:comment)       { create(:comment, id: 1, comment_by: 1, commented_on: 1, visibility: 'all') }
        let!(:new_moment)    { create(:moment, id: 1, userid: 1) }

        it 'destroys the comment' do
          expect { get :delete_comment, commentid: 1 }.to change(Comment, :count).by(-1)
        end

        it 'renders nothing' do
          comment
          get :delete_comment, commentid: 1

          expect(response.body).to eq("")
        end
      end

      context 'when the comment does not exist' do
        it 'renders nothing' do
          get :delete_comment, commentid: 1

          expect(response.body).to eq("")
        end
      end
    end

    context 'when the user is not logged in' do
      before do
        get :delete_comment
      end

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'Moment Analytic Charts' do

    it 'should contain react analytics objects' do
      create_time = Date.current
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      create(:moment, userid: new_user.id, category: Array.new(1, new_category.id),
             mood: Array.new(1, new_mood.id), created_at: create_time)

      get :index

      expect(assigns(:react_moments)).to have_key(create_time)
      expect(assigns(:react_moments)[create_time]).to eq(1)
    end
  end
end
