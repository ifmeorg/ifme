# frozen_string_literal: true
# == Schema Information
#
# Table name: moments
#
#  id                       :bigint           not null, primary key
#  name                     :string
#  why                      :text
#  fix                      :text
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#  viewers                  :text
#  comment                  :boolean
#  slug                     :string
#  secret_share_identifier  :uuid
#  secret_share_expires_at  :datetime
#  published_at             :datetime
#  bookmarked               :boolean          default(FALSE)
#  resource_recommendations :boolean          default(TRUE)
#

describe Moment do
  it { is_expected.to respond_to :friendly_id }

  context 'with validations' do
    it { is_expected.to belong_to(:user) }
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
    it { is_expected.to have_many :moments_categories }
    it { is_expected.to have_many(:categories).through(:moments_categories) }
    it { is_expected.to have_many :moments_strategies }
    it { is_expected.to have_many(:strategies).through(:moments_strategies) }
  end

  context 'with serialize' do
    it { is_expected.to serialize :viewers }
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

  describe 'crisis prevention acknowledgment reset' do
    let(:original_why) { 'I am feeling overwhelmed and need support.' }
    let(:moment) do
      create(:moment, :with_user,
             why: original_why,
             crisis_prevention_acknowledged: true,
             crisis_prevention_acknowledged_text: original_why)
    end

    context 'when the why text has not changed' do
      it 'keeps the acknowledgment' do
        moment.update!(name: 'Updated name')
        expect(moment.reload.crisis_prevention_acknowledged).to be true
      end
    end

    context 'when the why text changes by 30% or less' do
      it 'keeps the acknowledgment' do
        # Change one word in a longer sentence (well under 30%)
        new_why = 'I am feeling overwhelmed and need support today.'
        moment.update!(why: new_why)
        expect(moment.reload.crisis_prevention_acknowledged).to be true
      end
    end

    context 'when the why text changes by more than 30%' do
      it 'resets the acknowledgment' do
        moment.update!(why: 'Completely different content about something else entirely now.')
        expect(moment.reload.crisis_prevention_acknowledged).to be false
        expect(moment.reload.crisis_prevention_acknowledged_text).to be_nil
      end
    end

    context 'when the why text is completely replaced' do
      it 'resets the acknowledgment' do
        moment.update!(why: 'New text with no overlap from the original entry.')
        expect(moment.reload.crisis_prevention_acknowledged).to be false
      end
    end

    context 'when the moment is not yet acknowledged' do
      let(:moment) do
        create(:moment, :with_user,
               why: original_why,
               crisis_prevention_acknowledged: false,
               crisis_prevention_acknowledged_text: nil)
      end

      it 'does not change acknowledged state on update' do
        moment.update!(why: 'Completely different content about something else entirely now.')
        expect(moment.reload.crisis_prevention_acknowledged).to be false
      end
    end
  end
end
