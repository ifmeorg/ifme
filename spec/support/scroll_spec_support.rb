module ScrollSpecSupport

  # sometimes the sticky header gets in the way
  # of clicking on elements. it's not ideal to
  # use javascript to click the element
  # (instead of page.find(thing).click), but
  # Selenium will try to scroll to the element when
  # you use find, so we need to avoid doing that
  # since we've done the work of scrolling the element
  # into view.

  # arguably we don't need to scroll at all, we could just
  # .click(), but it's closer to real-life interactions
  # if we scroll the page first.
  def scroll_to_and_click(selector)
    element = "$('#{selector}')"
    page.execute_script "#{element}[0].scrollIntoView(false)"
    page.execute_script "#{element}.click()"
  end
end

RSpec.configure do |config|
  config.include ScrollSpecSupport, :type => :feature
end
