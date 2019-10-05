# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  uniqueid   :string
#  data       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Notification do
  context 'with relations' do
    it { is_expected.to belong_to :user }
  end

  context 'with validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :uniqueid }
    it { is_expected.to validate_presence_of :data }
  end

  it 'is valid with valid attributes' do
    notification = build(:notification)

    expect(notification).to be_valid
  end

  it 'is invalid without a user_id' do
    notification = build(:notification, user_id: nil)

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
