module CkeditorSpecSupport
  def fill_in_ckeditor(locator, options)
    content = options.fetch(:with).to_json
    page.execute_script <<-SCRIPT
      CKEDITOR.instances['#{locator}'].setData(#{content});
      $('textarea##{locator}').text(#{content});
    SCRIPT
  end
end

RSpec.configure do |config|
  config.include CkeditorSpecSupport, :type => :feature
end
