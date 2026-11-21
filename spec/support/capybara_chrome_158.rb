# frozen_string_literal: true

# ponytail: Chrome 158 rejects the '*' origin that Capybara sends to
# Storage.clearDataForOrigin at the end of every reset!, so all feature specs
# fail in teardown. Fallback: clear all cookies, then clear the app server's
# origin instead of '*'.
# Remove once a Capybara release > 3.40.0 ships the fix:
# https://github.com/teamcapybara/capybara/issues/2865
# https://github.com/teamcapybara/capybara/pull/2868
if Gem::Version.new(Capybara::VERSION) <= Gem::Version.new('3.40.0')
  Capybara::Selenium::Driver::ChromeDriver.prepend(Module.new do
    private

    def execute_cdp(cmd, params = {})
      super
    rescue Selenium::WebDriver::Error::InvalidArgumentError
      raise unless cmd == 'Storage.clearDataForOrigin' && params[:origin] == '*'

      super('Network.clearBrowserCookies')
      origin = Capybara.current_session.server&.base_url
      super(cmd, origin:, storageTypes: params[:storageTypes]) if origin
    end
  end)
end
