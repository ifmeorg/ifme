RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }

  describe '#link' do
    it 'category path' do
      # binding.pry
    end
  end
end
