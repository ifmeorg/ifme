# frozen_string_literal: true
# == Schema Information
#
# Table name: moments
#
#  id                      :bigint(8)        not null, primary key
#  category                :text
#  name                    :string
#  mood                    :text
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
  describe '.find_secret_share!' do
    context 'when a valid secret share moment exists' do
      let(:moment) { create(:moment, :with_user, :with_secret_share) }
      subject { Moment.find_secret_share!(moment.secret_share_identifier) }
      it { is_expected.to eq(moment) }
    end

    # TODO: Turn off temporarily
    # context 'when a secret share moment has expired' do
    #   let(:moment) do
    #     m = build(:moment, :with_user, :with_secret_share)
    #     m.secret_share_expires_at = 1.day.ago
    #     m.save!
    #     m
    #   end

    #   subject { Moment.find_secret_share!(moment.secret_share_identifier) }
    #   specify { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    # end

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
end
