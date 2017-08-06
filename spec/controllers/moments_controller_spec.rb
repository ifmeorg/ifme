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
      new_moment = attributes_for(:moment).merge(
        userid: new_user.id,
        category: [new_category.id],
        mood: [new_mood.id]
      )
      get :new
      expect(response).to render_template(:new)
      expect{ post :create,  params: { moment: new_moment } }.to(
        change(Moment, :count).by(1)
      )
    end

    it "GET show" do
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, userid: new_user.id)
      new_mood = create(:mood, userid: new_user.id)
      new_strategies = create(:strategy, userid: new_user.id)
      new_moment = create(
        :moment,
        userid: new_user.id,
        category: [new_category.id],
        mood: [new_mood.id],
        strategies: [new_strategies.id]
      )
      get :show, params: { id: new_moment }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST comment' do
    let(:user) { create(:user, id: 1) }
    let!(:new_moment) { create(:moment, id: 1, userid: 1) }
    let(:valid_comment_params) do
      attributes_for(:comment)
        .merge(comment_by: 1, commented_on: 1, visibility: 'all')
    end
    let(:invalid_comment_params) { attributes_for(:comment, commented_on: 1) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment is saved' do
        it 'responds with an OK status' do
          post :comment, :params => valid_comment_params

          expect(response.status).to eq(200)
        end
      end

      context 'when the comment is not saved' do
        it 'responds with json no_save: true' do
          post :comment, :params => invalid_comment_params

          expect(response.body).to eq({no_save: true}.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :comment }

      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET delete_comment' do
    let(:user) { create(:user, id: 1) }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when the comment exists and belongs to the current_user' do
        let!(:new_moment) { create(:moment, id: 1, userid: 1) }
        let!(:comment) do
          create(
            :comment, id: 1, comment_by: 1, commented_on: 1, visibility: 'all'
          )
        end

        it 'destroys the comment' do
          expect { get :delete_comment, params: { commentid: 1 } }.to(
            change(Comment, :count).by(-1)
          )
        end

        it 'renders nothing' do
          get :delete_comment, params: { commentid: 1 }

          expect(response.body).to eq("")
        end
      end

      context 'when the comment exists and the strategy belongs to the current_user' do
        let!(:comment) do
          create(
            :comment, id: 1, comment_by: 1, commented_on: 1, visibility: 'all'
          )
        end
        let!(:new_moment) { create(:moment, id: 1, userid: 1) }

        it 'destroys the comment' do
          expect { get :delete_comment, params: { commentid: 1 } }.to(
            change(Comment, :count).by(-1)
          )
        end

        it 'renders nothing' do
          comment
          get :delete_comment, params: { commentid: 1 }

          expect(response.body).to eq("")
        end
      end

      context 'when the comment does not exist' do
        it 'renders nothing' do
          get :delete_comment, params: { commentid: 1 }

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
end
