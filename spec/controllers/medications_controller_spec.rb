describe MedicationsController do
  describe '#print_reminders' do
    let(:user) { FactoryBot.create(:user1) }

    subject { controller.print_reminders(medication) }

    describe 'when medication has no reminders' do
      let(:medication) { FactoryBot.create(:medication, user_id: user.id) }

      it 'is empty' do
        expect(subject).to eq('')
      end
    end

    describe 'when medication has refill reminder' do
      let(:medication) { FactoryBot.create(:medication, :with_refill_reminder, user_id: user.id) }

      it 'prints the reminder' do
        expect(subject).to eq('<div class="small_margin_top"><i class="fa fa-bell small_margin_right"></i>Refill reminder email</div>')
      end
    end

    describe 'when medication has daily reminder' do
      let(:medication) { FactoryBot.create(:medication, :with_daily_reminder, user_id: user.id) }

      it 'prints the reminders' do
        expect(subject).to eq('<div class="small_margin_top"><i class="fa fa-bell small_margin_right"></i>Daily reminder email</div>')
      end
    end

    describe 'when medication has both reminders' do
      let(:medication) { FactoryBot.create(:medication, :with_both_reminders, user_id: user.id) }

      it 'prints the reminders' do
        expect(subject).to eq('<div class="small_margin_top"><i class="fa fa-bell small_margin_right"></i>Refill reminder email, Daily reminder email</div>')
      end
    end

    describe 'DELETE #destroy' do
      let(:user) { create(:user) }
      let!(:medication) { create(:medication, user: user) }

      context 'when the user is logged in' do
        include_context :logged_in_user
        it 'deletes the medication' do
          expect { delete :destroy, params: { id: medication.id } }
            .to change(Medication, :count).by(-1)
        end

        it 'redirects to the medications index page' do
          delete :destroy, params: { id: medication.id }
          expect(response).to redirect_to medications_path
        end
      end

      context 'when the user is not logged in' do
        before { delete :destroy, params: { id: medication.id } }
        it_behaves_like :with_no_logged_in_user
      end
    end
  end

  describe 'GET #index' do
    let(:user) { create(:user) }
    let!(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end
    end
    context 'when not signed in' do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }
    let(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }
      it 'renders the new page' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when not signed in' do
      before { get :new }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }
      it 'render the show page' do
        medication.save!
        get :show, params: { id: medication.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when not signed in' do
      before { get :show, params: { id: medication.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user1) }
    let(:valid_medication_params) { attributes_for(:medication) }

    def post_create(medication_params)
      post :create, params: { medication: medication_params }
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when valid params are supplied' do
        it 'creates a medication' do
          expect { post_create valid_medication_params }
            .to change(Medication, :count).by(1)
        end

        it 'has no validation errors' do
          post_create valid_medication_params
          expect(assigns(:medication).errors).to be_empty
        end

        it 'redirects to the medication page' do
          post_create valid_medication_params
          expect(response).to redirect_to medication_path(assigns(:medication))
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_medication_params) { valid_medication_params.merge(name: nil, dosage: nil) }

        before { post_create invalid_medication_params }

        it 're-renders the creation form' do
          expect(response).to render_template(:new)
        end

        it 'adds errors to the medication ivar' do
          expect(assigns(:medication).errors).not_to be_empty
        end
      end

      context 'when the user_id is hacked' do
        it 'creates a new medication, ignoring the user_id parameter' do
          # passing a user_id isn't an error, but it shouldn't
          # affect the owner of the created item
          another_user = create(:user2)
          hacked_medication_params =
            valid_medication_params.merge(user_id: another_user.id)
          expect { post_create hacked_medication_params }
            .to change(Medication, :count).by(1)
          expect(Medication.last.user_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :create }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
