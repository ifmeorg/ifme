require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "use factory of some_railtie" do
    user = FactoryBot.create(:factory_from_some_railtie)
    assert_equal 'Artem', user.name
  end
end