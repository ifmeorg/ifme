# frozen_string_literal: true
# == Schema Information
#
# Table name: moments
#
#  id                      :bigint(8)        not null, primary key
#  category                :text
#  name                    :string
#  why                     :text
#  fix                     :text
#  created_at              :datetime
#  updated_at              :datetime
#  user_id                 :integer
#  viewers                 :text
#  comment                 :boolean
#  strategy                :text
#  slug                    :string
#  secret_share_identifier :uuid
#  secret_share_expires_at :datetime
#  published_at            :datetime
#

describe Moment do
  it { is_expected.to respond_to :friendly_id }

  context 'with validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :why }
    it { is_expected.to validate_length_of(:why).is_at_least(1) }
    context 'when validating secret_share_expires_at' do
      context 'with secret_share_identifier? true' do
        before do
          allow_any_instance_of(Moment).to receive(:secret_share_identifier?).and_return true
        end

        it { is_expected.to validate_presence_of :secret_share_expires_at }
      end

      context 'with secret_share_identifier? false' do
        before do
          allow_any_instance_of(Moment).to receive(:secret_share_identifier?).and_return false
        end

        it { is_expected.to_not validate_presence_of :secret_share_expires_at }
      end
    end
  end

  context 'with relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :comments }
    it { is_expected.to have_many :moments_moods }
    it { is_expected.to have_many(:moods).through(:moments_moods) }
  end

  context 'with serialize' do
    it { is_expected.to serialize :category }
    it { is_expected.to serialize :viewers }
    it { is_expected.to serialize :strategy }
  end

  describe '.find_secret_share!' do
    context 'when a valid secret share moment exists' do
      let(:moment) { create(:moment, :with_user, :with_secret_share) }
      subject { Moment.find_secret_share!(moment.secret_share_identifier) }
      it { is_expected.to eq(moment) }
    end

    # TODO: Skipped temporarily
    xcontext 'when a secret share moment has expired' do
      let(:moment) do
        m = build(:moment, :with_user, :with_secret_share)
        m.secret_share_expires_at = 1.day.ago
        m.save!
        m
      end

      subject { Moment.find_secret_share!(moment.secret_share_identifier) }
      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'when there is no secret share moment' do
      subject { Moment.find_secret_share!('foobar') }
      specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe '#owned_by?' do
    let(:moment) { build(:moment, :with_user) }
    let(:user) { moment.user }
    let(:subject) { moment.owned_by?(user) }

    it { is_expected.to be true }

    context 'when the user does not own the moment' do
      let(:user) { create(:user) }
      it { is_expected.to be false }
    end
  end

  describe '#published?' do
    context 'when it has a publication date' do
      let(:moment) { build(:moment, :with_user, :with_published_at) }
      let(:subject) { moment.published? }

      it { is_expected.to be true }
    end
    context 'when it does not have a publication date' do
      let(:moment) { create(:moment, :with_user) }
      let(:subject) { moment.published? }
      it { is_expected.to be false }
    end
  end

  describe '#mood_array_data' do
    let!(:moment) { create(:moment, :with_user) }
    let!(:mood) { create(:mood, user: moment.user) }

    context 'saving moods via relation' do
      let!(:mood_two) { create(:mood, user: moment.user) }

      it 'creates relations between moment and mood models' do
        expect(moment.moods.count).to eq(0)
        moment.mood = [mood.id.to_s, mood_two.id.to_s]
        moment.save

        expect(moment.moods.count).to eq(2)
        expect(moment.moods).to include(mood)
        expect(moment.moods).to include(mood_two)
      end

      it 'removes old moods when updating' do
        moment.mood = [mood.id.to_s]
        moment.save
        expect(moment.moods).to eq [mood]

        moment.mood = [mood_two.id.to_s]
        moment.save
        expect(moment.moods).to eq [mood_two]
      end
    end
  end
end
