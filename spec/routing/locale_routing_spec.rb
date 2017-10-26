# frozen_string_literal: true

RSpec.describe 'locale routing', type: :routing do
  %w(en es nl ptbr sv).each do |locale|
    it 'should route all of our locale shortcuts' do
      expect(get: locale).to be_routable
      expect(get: locale).to route_to(
        controller: 'locales',
        action: 'set_initial_locale',
        locale: locale
      )
    end
  end
end
