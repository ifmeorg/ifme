# frozen_string_literal: true
describe MedicationsController do
  describe '#print_reminders' do
    let(:user) { create(:user1) }
    subject { controller.print_reminders(medication) }

    describe 'when medication has no reminders' do
      let(:medication) { create(:medication, user_id: user.id) }

      it 'is empty' do
        expect(subject).to eq('')
      end
    end

    describe 'when medication has refill reminder' do
      let(:medication) { create(:medication, :with_refill_reminder, user_id: user.id) }

      it 'prints the reminder' do
        expect(subject).to eq('<div><i class="fa fa-bell smallMarginRight"></i>Refill reminder email</div>')
      end
    end

    describe 'when medication has daily reminder' do
      let(:medication) { create(:medication, :with_daily_reminder, user_id: user.id) }

      it 'prints the reminders' do
        expect(subject).to eq('<div><i class="fa fa-bell smallMarginRight"></i>Daily reminder email</div>')
      end
    end

    describe 'when medication has both reminders' do
      let(:medication) { create(:medication, :with_both_reminders, user_id: user.id) }

      it 'prints the reminders' do
        expect(subject).to eq('<div><i class="fa fa-bell smallMarginRight"></i>Refill reminder email, Daily reminder email</div>')
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

  describe '#index' do
    let(:user) { create(:user) }
    let!(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }

      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end

      context 'when request type is JSON' do
        before { get :index, params: { page: 1, id: medication.id }, format: :json }
        it 'returns a response with the correct path' do
          expect(JSON.parse(response.body)['data'].first['link']).to eq medication_path(medication)
        end
      end
    end

    context 'when not signed in' do
      before { get :index }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#new' do
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

  describe '#show' do
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

  describe '#create' do
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

        context 'when refill exists' do
          it 'has no validation errors and has correct refill' do
            post_create valid_medication_params
            expect(assigns(:medication).errors).to be_empty
            expect(assigns(:medication)[:refill].strftime('%d/%m/%Y')).to eq('01/01/2020')
          end
        end

        context 'when refill does not exist' do
          it 'has no validation errors and uses auto-generated refill' do
            post_create valid_medication_params.merge(refill: nil)
            expect(assigns(:medication).errors).to be_empty
            expect(assigns(:medication)[:refill]).to be_between(assigns(:medication)[:created_at].to_date,
              ((7 * assigns(:medication)[:total]) / (assigns(:medication)[:dosage] * assigns(:medication)[:weekly_dosage].count)).days.from_now)
          end
        end

        it 'redirects to the medication page' do
          post_create valid_medication_params
          expect(response).to redirect_to medication_path(assigns(:medication))
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_medication_params) { valid_medication_params.merge(name: nil, dosage: nil) }
        before { post_create invalid_medication_params }

        it 're-renders the new medication form' do
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

  describe '#update' do
    let(:user) { create(:user1) }
    let!(:medication) { create(:medication, user_id: user.id) }
    let!(:valid_medication_params) { { name: 'Updated Medication Name' } }

    def put_update(medication_params)
      put :update, params: { id: medication.id, medication: medication_params }
    end

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when valid params are supplied' do
        it 'updates a medication' do
          put_update valid_medication_params
          expect(assigns(:medication)[:name]).to eq(valid_medication_params[:name])
        end

        context 'when refill is updated to a new date' do
          it 'has no validation errors and has correct refill' do
            put_update valid_medication_params.merge(refill: '12/12/2020')
            expect(assigns(:medication).errors).to be_empty
            expect(assigns(:medication)[:refill].strftime('%d/%m/%Y')).to eq('12/12/2020')
          end
        end

        context 'when refill is update to an empty value' do
          it 'has no validation errors and uses auto-generated refill' do
            put_update valid_medication_params.merge(refill: nil)
            expect(assigns(:medication).errors).to be_empty
            expect(assigns(:medication)[:refill]).to be_between(assigns(:medication)[:updated_at].to_date,
              ((7 * assigns(:medication)[:total]) / (assigns(:medication)[:dosage] * assigns(:medication)[:weekly_dosage].count)).days.from_now)
          end
        end

        it 'redirects to the medication page' do
          put_update valid_medication_params
          expect(response).to redirect_to medication_path(assigns(:medication))
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_medication_params) { valid_medication_params.merge(name: nil, dosage: nil) }
        before { put_update invalid_medication_params }

        it 're-renders the new medication form' do
          expect(response).to render_template(:new)
        end

        it 'adds errors to the medication ivar' do
          expect(assigns(:medication).errors).not_to be_empty
        end
      end

      context 'when the user_id is hacked' do
        it 'updates a medication, ignoring the user_id parameter' do
          another_user = create(:user2)
          hacked_medication_params =
            valid_medication_params.merge(user_id: another_user.id)
          put_update hacked_medication_params
          expect(Medication.last.user_id).to eq(user.id)
        end
      end
    end

    context 'when the user is not logged in' do
      before { put :update, params: { id: medication.id } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    context 'when medication has no reminders' do
      let!(:medication) { create(:medication, user: user) }

      context 'when the user is logged in' do
        include_context :logged_in_user

        it 'destroys the medication' do
          expect { delete :destroy, params: { id: medication.id } }.to(
            change(Medication, :count).by(-1)
          )
        end

        it 'redirects to the medications path for html requests' do
          delete :destroy, params: { id: medication.id }
          expect(response).to redirect_to(medications_path)
        end

        it 'responds with no content to json requests' do
          delete :destroy, format: 'json', params: { id: medication.id }
          expect(response.body).to be_empty
        end
      end

      context 'when the user is not logged in' do
        before { delete :destroy, params: { id: medication.id } }

        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'when medication has a daily reminder' do
      let!(:medication) do
        create(:medication, :with_daily_reminder, user: user)
      end

      context 'when the user is logged in' do
        include_context :logged_in_user

        it 'destroys the medication' do
          expect(TakeMedicationReminder.active.count).to eq(1)
          expect { delete :destroy, params: { id: medication.id } }.to(
            change(Medication, :count).by(-1)
          )
          expect(TakeMedicationReminder.active.count).to eq(0)
        end

        it 'redirects to the medications path for html requests' do
          delete :destroy, params: { id: medication.id }
          expect(response).to redirect_to(medications_path)
        end

        it 'responds with no content to json requests' do
          delete :destroy, format: 'json', params: { id: medication.id }
          expect(response.body).to be_empty
        end
      end

      context 'when the user is not logged in' do
        before { delete :destroy, params: { id: medication.id } }

        it_behaves_like :with_no_logged_in_user
      end
    end

    context 'when medication has a refill reminder' do
      let!(:medication) do
        create(:medication, :with_refill_reminder, user: user)
      end

      context 'when the user is logged in' do
        include_context :logged_in_user

        it 'destroys the medication' do
          expect(RefillReminder.active.count).to eq(1)
          expect { delete :destroy, params: { id: medication.id } }.to(
            change(Medication, :count).by(-1)
          )
          expect(RefillReminder.active.count).to eq(0)
        end

        it 'redirects to the medications path for html requests' do
          delete :destroy, params: { id: medication.id }
          expect(response).to redirect_to(medications_path)
        end

        it 'responds with no content to json requests' do
          delete :destroy, format: 'json', params: { id: medication.id }
          expect(response.body).to be_empty
        end
      end

      context 'when the user is not logged in' do
        before { delete :destroy, params: { id: medication.id } }

        it_behaves_like :with_no_logged_in_user
      end
    end
  end
end
