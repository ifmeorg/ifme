# frozen_string_literal: true

module PageTransitionSupport
  def change_language(language_code)
    within 'select[name=locale]' do
      find("option[value=#{language_code}]").click
      expect(
        find("option[value=#{language_code}][selected]", wait: 5)
      ).to be_present
    end
  end
end

RSpec.configure do |config|
  config.include PageTransitionSupport, type: :feature
end
