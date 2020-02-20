# frozen_string_literal: true

module PageTransitionSupport
  def change_language(language_code)
    within 'select[name=locale]' do
      find("option[value=#{language_code}]").click
      expect(
        find("option[value=#{language_code}]", wait: 10)
      ).to be_visible
    end
  end

  def change_page(trigger, check_for_element, condition = be_present)
    trigger.call
    expect(find(check_for_element, wait: 10)).to condition
  end
end

RSpec.configure do |config|
  config.include PageTransitionSupport, type: :feature
end
