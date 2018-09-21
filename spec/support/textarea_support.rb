module TextareaSupport
  def fill_in_textarea(text, locator)
    within(locator) {
      find('.editorContent', visible: false).send_keys('')
      find('.editorContent', visible: false).send_keys(text)
    }
  end
end

RSpec.configure do |config|
  config.include TextareaSupport, type: :feature
end
