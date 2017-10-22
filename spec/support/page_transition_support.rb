module PageTransitionSupport
  def change_language(languageCode)
    within 'select[name=locale]' do
      find("option[value=#{languageCode}]").click
      expect(find("option[value=#{languageCode}]")).to \
        have_xpath("//option[@selected='selected']")
    end
  end
end
    
RSpec.configure do |config|
  config.include PageTransitionSupport, :type => :feature
end
