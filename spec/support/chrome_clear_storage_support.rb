# frozen_string_literal: true

require 'capybara/selenium/driver'

# Capybara 3.39.2 resets the Chrome browser state between examples with
# Storage.clearDataForOrigin and `origin: '*'`. Recent Chrome releases
# (158+) reject that wildcard with "invalid argument: * is not a valid URL",
# which fails every browser (feature) spec.
#
# Clear the same data without the wildcard: all cookies through
# Storage.clearCookies, and any other storage (e.g. local storage) for the
# origin of the Capybara app server, which is the only origin the specs use.
#
# Remove this once Capybara ships a release that no longer sends the wildcard.
module ChromeClearStorageSupport
  WILDCARD_ORIGIN = '*'

  def execute_cdp(cmd, params = {})
    return super unless cmd == 'Storage.clearDataForOrigin' &&
                        params[:origin] == WILDCARD_ORIGIN

    storage_types = params[:storageTypes].to_s.split(',')
    super('Storage.clearCookies', {}) if storage_types.delete('cookies')
    clear_storage_for_app_server(cmd, params, storage_types)
  end

  private

  def clear_storage_for_app_server(cmd, params, storage_types)
    origin = Capybara.current_session.server&.base_url
    return if origin.nil? || storage_types.empty?

    execute_cdp(cmd, params.merge(origin:, storageTypes: storage_types.join(',')))
  end
end

Capybara::Selenium::Driver::ChromeDriver.prepend(ChromeClearStorageSupport)
