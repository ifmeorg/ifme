# frozen_string_literal: true

describe 'Locales', type: :request do
  let(:user) { create(:user, locale: nil) }

  Rails.configuration.i18n.available_locales.each do |locale|
    describe "GET ##{locale}" do
      context 'when the user is logged in' do
        before { sign_in user }

        it 'sets a locale cookie when prompted' do
          get "/#{locale}", params: { locale: locale.to_s }

          expect( response ).to redirect_to(root_path)
          expect( user.reload.locale ).to eq(locale.to_s)
          
        end
      end

      context 'when user is not logged' do
        it 'sets a locale cookie when prompted' do
          get "/#{locale}", params: { locale: locale.to_s }

          expect( response.cookies['locale'] ).to eq(locale.to_s)
          expect( response ).to redirect_to(root_path)
        end
      end

    end
  end

end
