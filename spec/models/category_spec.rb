RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
end
