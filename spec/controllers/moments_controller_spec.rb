# frozen_string_literal: true

describe MomentsController do
  context 'when signed in' do
    let(:user) { create(:user) }
    let(:moment) { build(:moment, user: user) }

    before { sign_in user }

    it 'GET index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'POST new' do
      get :new
      expect(response).to render_template(:new)
      expect { post :create, params: { moment: moment.attributes } }
        .to(change(Moment, :count).by(1))
    end

    it 'GET show' do
      moment.save!
      get :show, params: { id: moment.id }
      expect(response).to render_template(:show)
    end

    context 'when request type is JSON' do
      let(:moment) { create(:moment, user: user) }
      before { get :index, params: { page: 1, id: moment.id }, format: :json }
      it 'returns a response with the correct path' do
        expect(JSON.parse(response.body)['data'].first['link']).to eq moment_path(moment)
      end
    end

    describe 'POST create' do
      let(:valid_moment_params) { attributes_for(:moment) }

      def post_create(moment_params)
        post :create, params: { moment: moment_params }
      end

      context 'when valid params are supplied' do
        it 'creates a moment' do
          expect { post_create valid_moment_params }
            .to change(Moment, :count).by(1)
        end

        it 'has no validation errors' do
          post_create valid_moment_params
          expect(assigns(:moment).errors).to be_empty
        end

        it 'redirects to the moment page' do
          post_create valid_moment_params
          expect(response).to redirect_to moment_path(assigns(:moment))
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_moment_params) { valid_moment_params.merge(name: nil, why: nil) }

        before { post_create invalid_moment_params }

        it 're-renders the creation form' do
          expect(response).to render_template(:new)
        end

        it 'adds errors to the moment ivar' do
          expect(assigns(:moment).errors).not_to be_empty
        end
      end

      context 'when the useri_d is hacked' do
        it 'creates a new moment, ignoring the useri_d parameter' do
          # passing a useri_d isn't an error, but it shouldn't
          # affect the owner of the created item
          another_user = create(:user2)
          hacked_moment_params =
            valid_moment_params.merge(user_id: another_user.id)
          expect { post_create hacked_moment_params }
            .to change(Moment, :count).by(1)
          expect(Moment.last.user_id).to eq(user.id)
        end
      end
    end
  end

  describe 'Moment Analytic Charts' do
    it 'should contain react analytics objects' do
      create_time = Date.current
      new_user = create(:user1)
      sign_in new_user
      new_category = create(:category, user_id: new_user.id)
      new_mood = create(:mood, user_id: new_user.id)
      create(:moment, user_id: new_user.id, category: Array.new(1, new_category.id),
                      mood: Array.new(1, new_mood.id), created_at: create_time)
      get :index
      expect(assigns(:react_moments)).to have_key(create_time)
      expect(assigns(:react_moments)[create_time]).to eq(1)
    end
  end
end
