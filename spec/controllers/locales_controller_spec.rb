# frozen_string_literal: true

RSpec.describe LocalesController, type: :controller do
  %w(en es nl ptbr sv).each do |locale|
    describe "GET ##{locale}" do
      it 'sets a locale cookie when prompted' do
        get :set_initial_locale, params: { locale: locale }
        expect(response).to be_redirect
        expect(response.cookies['locale']).to eq(locale)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
