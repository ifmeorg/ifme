# frozen_string_literal: true
describe 'PageRedirectConcern', type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  describe '#if_not_signed_in' do
    context 'when the user is not signed in' do
      before { get new_moment_path }

      it_behaves_like :with_no_logged_in_user
    end

    context 'when the user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'redirects successfully' do
        get new_moment_path
        expect(response).to be_successful
      end
    end
  end

  describe '#if_not_admin' do
    context 'when the user is not signed in' do
      before { get admin_dashboard_path }

      it_behaves_like :with_no_logged_in_user
    end

    context 'when the user is signed in' do
      context 'and not an admin' do
        before(:each) do
          sign_in user
        end

        it 'redirects to the home page' do
          get admin_dashboard_path
          expect(response).to redirect_to '/'
        end
      end

      context 'and an admin' do
        before(:each) do
          sign_in admin
        end

        it 'redirects to admin dashboard page' do
          get admin_dashboard_path
          expect(response).to be_successful
        end
      end
    end
  end

  describe '#redirect_to_path' do
    context 'for a non-signed in path' do
      it 'redirects successfully' do
        get partners_path
        expect(response).to be_successful
      end
    end

    context 'for a signed in path' do
      before(:each) do
        sign_in user
      end

      it 'redirects successfully' do
        get care_plan_path
        expect(response).to be_successful
      end
    end
  end
end
