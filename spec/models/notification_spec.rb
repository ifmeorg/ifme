# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  userid     :integer
#  uniqueid   :string
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Notification do
  it 'is valid with valid attributes' do
    notification = build(:notification)

    expect(notification).to be_valid
  end

  it 'is invalid without a user_id' do
    notification = build(:notification, userid: nil)

    expect(notification).to_not be_valid
  end

  it 'is invalid without a uniqueid' do
    notification = build(:notification, uniqueid: nil)

    expect(notification).to_not be_valid
  end

  it 'is invalid without data' do
    notification = build(:notification, data: nil)

    expect(notification).to_not be_valid
  end

  it 'belongs to a user' do
    assc = described_class.reflect_on_association(:user)

    expect(assc.macro).to eq :belongs_to
  end

end
