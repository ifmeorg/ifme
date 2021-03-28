# frozen_string_literal: true

RSpec.describe 'MomentTemplate', type: :request do
  let(:user) { create(:user) }

  describe '#create' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        it 'creates the moment template' do
          post moment_templates_create_path, params: {
            moment_template: {
              name: 'Name', description: 'Description'
            }
          }

          expect(response).to be_successful
          expect(JSON.parse(response.body)).to eq(
            'id' => MomentTemplate.last.id,
            'name' => MomentTemplate.last.name,
            'description' => MomentTemplate.last.description
          )
        end
      end

      context 'when invalid params are supplied' do
        it 'returns 422 UNPROCESSABLE ENTITY' do
          post moment_templates_create_path, params: {
            moment_template: { name: nil }
          }

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to sign_in page' do
        post moment_templates_create_path, params: {
          moment_template: {
            name: 'Name', description: 'Description'
          }
        }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        it 'updates the moment template' do
          moment_template = create(:moment_template, user_id: user.id)

          patch moment_templates_update_path, params: {
            id: moment_template.id,
            moment_template: { name: 'Different Name' }
          }

          expect(JSON.parse(response.body)).to eq(
            'id' => moment_template.id,
            'name' => 'Different Name',
            'description' => moment_template.description
          )
        end
      end

      context 'when invalid params are supplied' do
        it 'returns 422 UNPROCESSABLE ENTITY' do
          moment_template = create(:moment_template, user_id: user.id)

          patch moment_templates_update_path, params: {
            id: moment_template.id,
            moment_template: { name: nil }
          }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(moment_template.reload.name).not_to be_nil
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to sign_in page' do
        moment_template = create(:moment_template, user_id: user.id)

        patch moment_templates_update_path, params: {
          id: moment_template.id,
          moment_template: { name: 'Different Name' }
        }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context 'when the user is logged in' do
      before { sign_in user }

      context 'when valid params are supplied' do
        it 'deletes the moment template' do
          moment_template = create(:moment_template, user_id: user.id)

          delete moment_templates_destroy_path, params: { id: moment_template.id }

          expect(MomentTemplate.find_by_id(moment_template.id)).to be_nil
          expect(response).to redirect_to moment_templates_path
        end
      end

      context 'when invalid params are supplied' do
        it 'does not delete any moment_template' do
          moment_template = create(:moment_template, user_id: user.id)

          delete moment_templates_destroy_path, params: { id: -1 }

          expect(MomentTemplate.find_by_id(moment_template.id)).not_to be_nil
          expect(response).to redirect_to moment_templates_path
        end
      end
    end

    context 'when the user is not logged in' do
      it 'redirects to sign_in page' do
        moment_template = create(:moment_template, user_id: user.id)

        delete moment_templates_destroy_path, params: { id: moment_template.id }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
