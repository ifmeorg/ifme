# frozen_string_literal: true

describe CarePlanContactsController do
  let(:user) { create(:user1) }

  describe '#create' do
    let(:valid_params) { attributes_for(:care_plan_contact) }
    let(:invalid_params) { { name: nil } }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when valid params are supplied' do
        it 'creates the care plan contact' do
          expect { post :create, params: { care_plan_contact: valid_params } }
            .to change(CarePlanContact, :count).by 1
          expect(response.body).to eq({
            success: true,
            id: CarePlanContact.last.id,
            name: CarePlanContact.last.name,
            phone: CarePlanContact.last.phone
            }.to_json)
        end
      end

      context 'when invalid params are supplied' do
        it 'responds with an error in json format' do
          post :create, params: { care_plan_contact: invalid_params }
          expect(response.body).to eq({ success: false }.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { post :create, params: { care_plan_contact: valid_params } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#update' do
    let(:care_plan_contact) { create(:care_plan_contact, user_id: user.id) }
    let(:valid_params) {{ name: 'Great Person' } }
    let(:invalid_params) { { name: nil } }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when valid params are supplied' do
        it 'updates the care plan contact' do
          patch :update, params: { id: care_plan_contact.id, care_plan_contact: valid_params }
          expect(response.body).to eq({
            success: true,
            id: care_plan_contact.id,
            name: 'Great Person',
            phone: care_plan_contact.phone
            }.to_json)
        end
      end

      context 'when invalid params are supplied' do
        it 'responds with an error in json format' do
          post :create, params: { care_plan_contact: invalid_params }
          expect(response.body).to eq({ success: false }.to_json)
        end
      end
    end

    context 'when the user is not logged in' do
      before { patch :update, params: { id: care_plan_contact.id, care_plan_contact: valid_params } }
      it_behaves_like :with_no_logged_in_user
    end
  end

  describe '#destroy' do
    let(:care_plan_contact) { create(:care_plan_contact, user_id: user.id) }
    let(:valid_params) { { id: care_plan_contact.id } }
    let(:invalid_params) { { id: -1 } }

    context 'when the user is logged in' do
      include_context :logged_in_user

      context 'when valid params are supplied' do
        it 'deletes the care plan contact' do
          expect { delete :destroy, params: valid_params }
            .to change(CarePlanContact, :count).by 0
          expect(response).to redirect_to care_plan_path
        end
      end

      context 'when invalid params are supplied' do
        it 'responds with an error in json format' do
          expect { delete :destroy, params: invalid_params }
            .to change(CarePlanContact, :count).by 0
          expect(response).to redirect_to care_plan_path
        end
      end
    end

    context 'when the user is not logged in' do
      before { delete :destroy, params: valid_params }
      it_behaves_like :with_no_logged_in_user
    end
  end
end