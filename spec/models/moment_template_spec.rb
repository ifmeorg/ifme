# == Schema Information
#
# Table name: moment_templates
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  slug        :string
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

describe MomentTemplate do
  it { is_expected.to respond_to :friendly_id }

  context 'with validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }

    it 'is invalid without a name' do
      moment_template = build(:moment_template, name: nil)
      expect(moment_template).to have(1).error_on(:name)
    end

    it 'is invalid without a description' do
      moment_template = build(:moment_template, description: nil)
      expect(moment_template).to have(1).error_on(:description)
    end
  end

  context 'with relations' do
    it { is_expected.to belong_to :user }
  end
end
