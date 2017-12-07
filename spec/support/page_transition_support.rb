module PageTransitionSupport
  def change_language(languageCode)
    within 'select[name=locale]' do
      find("option[value=#{languageCode}]").click
      expect(find("option[value=#{languageCode}][selected]", wait: 5)).to be_present
    end
  end
end

RSpec.configure do |config|
  config.include PageTransitionSupport, :type => :feature
end
