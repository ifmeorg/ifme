# frozen_string_literal: true

RSpec.describe 'locale routing', type: :routing do
  Rails.configuration.i18n.available_locales.each do |locale|
    it 'should route all of our locale shortcuts' do
      expect(get: locale.to_s).to be_routable
      expect(get: locale.to_s).to route_to(
        controller: 'locales',
        action: 'set_initial_locale',
        locale: locale.to_s
      )
    end
  end
end
