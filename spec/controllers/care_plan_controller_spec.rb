# frozen_string_literal: true

describe CarePlanController do
  describe '#index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'renders template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not signed in' do
      it 'does not render the template' do
        get :index
        expect(response).to_not render_template(:index)
      end
    end
  end
end
