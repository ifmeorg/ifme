# frozen_string_literal: true

RSpec.describe 'CarePlanContacts', type: :request do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        it 'creates the care plan contact' do
          valid_params = { name: 'Person Name', phone: '416000000' }

          post care_plan_contacts_create_path, params: { care_plan_contact: valid_params }

          expect(response).to be_successful
          expect(JSON.parse(response.body)).to eq(
            'id' => CarePlanContact.last.id,
            'name' => CarePlanContact.last.name,
            'phone' => CarePlanContact.last.phone
          )
        end
      end

      context 'when invalid params are supplied' do
        it 'returns 422 UNPROCESSABLE ENTITY' do
          invalid_params = { name: nil }

          post care_plan_contacts_create_path, params: { care_plan_contact: invalid_params }

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to sign_in page' do
        valid_params = { name: 'Person Name', phone: '416000000' }

        post care_plan_contacts_create_path, params: { care_plan_contact: valid_params }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        it 'updates the care plan contact' do
          care_plan_contact = create(:care_plan_contact, user_id: user.id)
          valid_params = { name: 'Different Name' }
          request_params = { id: care_plan_contact.id, care_plan_contact: valid_params }

          patch care_plan_contacts_update_path, params: request_params

          expect(JSON.parse(response.body)).to eq(
            'id' => care_plan_contact.id,
            'name' => 'Different Name',
            'phone' => care_plan_contact.phone
          )
        end
      end

      context 'when invalid params are supplied' do
        it 'returns 422 UNPROCESSABLE ENTITY' do
          care_plan_contact = create(:care_plan_contact, user_id: user.id)
          invalid_params = { name: nil }
          request_params = { id: care_plan_contact.id, care_plan_contact: invalid_params }

          patch care_plan_contacts_update_path, params: request_params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(care_plan_contact.reload.name).not_to be_nil
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to sign_in page' do
        care_plan_contact = create(:care_plan_contact, user_id: user.id)
        valid_params = { name: 'Different Name' }
        request_params = { id: care_plan_contact.id, care_plan_contact: valid_params }

        patch care_plan_contacts_update_path, params: request_params

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        it 'deletes the care plan contact' do
          care_plan_contact = create(:care_plan_contact, user_id: user.id)

          delete care_plan_contacts_destroy_path, params: { id: care_plan_contact.id }

          expect(CarePlanContact.find_by_id(care_plan_contact.id)).to be_nil
          expect(response).to redirect_to care_plan_path
        end
      end

      context 'when invalid params are supplied' do
        it 'does not delete any care_plan_contact' do
          care_plan_contact = create(:care_plan_contact, user_id: user.id)

          delete care_plan_contacts_destroy_path, params: { id: -1 }

          expect(CarePlanContact.find_by_id(care_plan_contact.id)).not_to be_nil
          expect(response).to redirect_to care_plan_path
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to sign_in page' do
        care_plan_contact = create(:care_plan_contact, user_id: user.id)

        delete care_plan_contacts_destroy_path, params: { id: care_plan_contact.id }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
