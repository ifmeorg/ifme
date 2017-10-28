# frozen_string_literal: true

RSpec.describe LocalesController, type: :controller do
  Rails.configuration.i18n.available_locales.each do |locale|
    describe "GET ##{locale}" do
      it 'sets a locale cookie when prompted' do
        get :set_initial_locale, params: { locale: locale.to_s }
        expect(response).to be_redirect
        expect(response.cookies['locale']).to eq(locale.to_s)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
