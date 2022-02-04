# frozen_string_literal: true
describe "Medications", type: :request do

  describe '#index' do
    let(:user) { create(:user) }
    let!(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }

      it 'returns a successful response' do
        get medications_path
        expect(response).to be_successful
      end

      context 'when request type is JSON' do
        before do get medications_path,
          params: { page: 1, id: medication.id },
          headers: { "ACCEPT" => "application/json" }
        end
        it 'returns a response with the correct path' do
          expect(JSON.parse(response.body)['data'].first['link'])
            .to eq medication_path(medication)
        end
      end
    end

    context 'when not signed in' do
      before { get medications_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#new' do
    let(:user) { create(:user) }
    let(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }
      it 'returns a successful response' do
        get new_medication_path
        expect(response).to be_successful
      end
    end

    context 'when not signed in' do
      before { get new_medication_path }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#show' do
    let(:user) { create(:user) }
    let(:medication) { create(:medication, user: user) }

    context 'when signed in' do
      before { sign_in user }

      context 'when the medication exists' do
        it 'returns a successful response' do
          medication.save!
          get medication_path(medication)
          expect(response).to be_successful
        end
      end

      context 'when the medication does not exist' do
        it 'redirects to the medications page' do
          get medication_path(medication.id + 1)
          expect(response).to redirect_to(medications_path)
        end
      end
    end

    context 'when not signed in' do
      before { get medication_path(medication) }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#create' do
    let(:user) { create(:user1) }
    let(:valid_medication_params) { attributes_for(:medication) }

    def post_create(medication_params)
      post medications_path, params: { medication: medication_params }
    end

    context 'when signed in' do
      before { sign_in user }

      context 'when valid params are supplied' do

        it 'creates a medication' do
          expect { post_create valid_medication_params }
            .to change(Medication, :count).by(1)
        end

        it 'redirects the user' do
          post_create valid_medication_params
          expect(response).to have_http_status(302)
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_medication_params) do
          valid_medication_params.merge(name: nil, dosage: nil)
        end

        context 'when the request is for html' do
          it 'returns a successful response' do
            post_create invalid_medication_params
            expect(response).to be_successful
          end
        end

        context 'when the request is for json' do
          it 'returns 422, unprocessable entity' do
            post medications_path,
              params: { medication: invalid_medication_params },
              headers: { "ACCEPT" => "application/json" }
            expect(response).to have_http_status(422)
          end
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

    context 'when not signed in' do
      before { post_create valid_medication_params }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#update' do
    let(:user) { create(:user1) }
    let!(:medication) { create(:medication, user_id: user.id) }
    let!(:valid_medication_params) { { name: 'Updated Medication Name' } }

    def put_update(medication_params)
      put medication_path(medication), params: { medication: medication_params }
    end

    context 'when signed in' do
      before { sign_in user }

      context 'when valid params are supplied' do

        it 'updates a medication' do
          updated_name_slug = (valid_medication_params[:name]).parameterize
          put_update valid_medication_params
          expect(response.body).to include(updated_name_slug)
        end

        it 'redirects the user' do
          put_update valid_medication_params
          expect(response).to have_http_status(302)
        end
      end

      context 'when invalid params are supplied' do
        let(:invalid_medication_params) do
          valid_medication_params.merge(name: nil, dosage: nil)
        end

        context 'when the request is for html' do
          it 'returns a successful response' do
            put_update invalid_medication_params
            expect(response).to be_successful
          end
        end

        context 'when the request is for json' do
          it 'returns 422, unprocessable entity' do
            put medication_path(medication),
              params: { medication: invalid_medication_params },
              headers: { "ACCEPT" => "application/json" }
            expect(response).to have_http_status(422)
          end
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

    context 'when not signed in' do
      before { put_update valid_medication_params }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    context 'when signed in' do
      before { sign_in user }
      json_header = { "ACCEPT" => "application/json" }

      context 'when medication has no reminders' do
        let!(:medication) { create(:medication, user: user) }

        it 'destroys the medication' do
          expect { delete medication_path(medication) }
            .to(change(Medication, :count).by(-1))
        end

        it 'redirects to the medications path for html requests' do
          delete medication_path(medication)
          expect(response).to redirect_to(medications_path)
        end

        it 'responds with no content to json requests' do
          delete medication_path(medication), headers: json_header
          expect(response.body).to be_empty
        end
      end

      context 'when medication has a daily reminder' do
        let!(:medication) { create(:medication, user: user) }

        before { medication.take_medication_reminder.update(active: true) }

        it 'destroys the medication' do
          expect {
            delete medication_path(medication)
          }.to change { Medication.count }.by(-1)
            .and change { TakeMedicationReminder.count }.to(0)
        end

        it 'redirects to the medications path for html requests' do
          delete medication_path(medication)
          expect(response).to redirect_to(medications_path)
        end

        it 'responds with no content to json requests' do
          delete medication_path(medication), headers: json_header
          expect(response.body).to be_empty
        end
      end

      context 'when medication has a refill reminder' do
        let!(:medication) { create(:medication, user: user) }

        before { medication.refill_reminder.update(active: true) }

        it 'destroys the medication' do
          expect {
            delete medication_path(medication)
          }.to change { Medication.count }.by(-1)
           .and change { RefillReminder.count }.to(0)
        end

        it 'redirects to the medications path for html requests' do
          delete medication_path(medication)
          expect(response).to redirect_to(medications_path)
        end

        it 'responds with no content to json requests' do
          delete medication_path(medication), headers: json_header
          expect(response.body).to be_empty
        end
      end
    end

    context 'when not signed in' do
      let!(:medication) { create(:medication, user: user) }
      before { delete medication_path(medication) }
      it_behaves_like :with_no_logged_in_user
    end
  end
end
