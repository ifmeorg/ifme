# frozen_string_literal: true

module TextareaSupport
  def fill_in_textarea(text, locator)
    within(locator) do
      editor = find('.editorContent', visible: false)
      editor.send_keys([modifier_key, 'a'])
      editor.send_keys(text)
    end
  end

  def modifier_key
    /darwin/i.match?(RbConfig::CONFIG['host_os']) ? :meta : :control
  end
end

RSpec.configure do |config|
  config.include TextareaSupport, type: :feature
end
