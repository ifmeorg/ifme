module CkeditorSpecSupport
  def fill_in_ckeditor(locator, options)
    # Make sure the editor has had time to load
    find "#cke_#{locator}"

    content = options.fetch(:with).to_json
    page.execute_script <<~SCRIPT
      var ckeditor = CKEDITOR.instances.#{locator};
      ckeditor.setData(#{content});
      ckeditor.focus();
      ckeditor.updateElement();
    SCRIPT
  end
end

RSpec.configure do |config|
  config.include CkeditorSpecSupport, type: :feature
end
