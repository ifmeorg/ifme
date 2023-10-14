# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  location               :string
#  timezone               :string
#  about                  :text
#  avatar                 :string
#  conditions             :text
#  token                  :string
#  uid                    :string
#  provider               :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default(0)
#  comment_notify         :boolean
#  ally_notify            :boolean
#  group_notify           :boolean
#  meeting_notify         :boolean
#  locale                 :string
#  access_expires_at      :datetime
#  refresh_token          :string
#  banned                 :boolean          default(FALSE)
#  admin                  :boolean          default(FALSE)
#  third_party_avatar     :text
#  failed_attempts        :integer          default(0), not null
#  locked_at              :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  session_token          :string
#

class User < ApplicationRecord
  include AllyConcern

  OAUTH_TOKEN_URL = 'https://accounts.google.com/o/oauth2/token'

  USER_DATA_ATTRIBUTES = %w[
    id
    email
    sign_in_count
    current_sign_in_at
    last_sign_in_at
    current_sign_in_ip
    last_sign_in_ip
    created_at
    updated_at
    name
    location
    timezone
    about
    conditions
    uid
    provider
    comment_notify
    ally_notify
    group_notify
    meeting_notify
    locale
    banned
    admin
  ].map!(&:freeze).freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :uid, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :confirmable, omniauth_providers: %i[google_oauth2 facebook]
  # https://github.com/michaelbanfield/devise-pwned_password#disabling-in-test-environments
  # TODO: reenable if we disable real network requests & stub them with Webmock
  # https://github.com/bblimke/webmock
  devise :pwned_password unless Rails.env.test?

  mount_uploader :avatar, AvatarUploader

  has_many :allyships
  has_many :allies, through: :allyships
  has_many :group_members
  has_many :groups, through: :group_members
  has_many :meeting_members
  has_many :medications
  has_many :strategies
  has_many :notifications
  has_many :moods
  has_many :moments
  has_many :categories
  has_many :care_plan_contacts
  has_many :moment_templates
  has_many :data_requests, class_name: 'Users::DataRequest'
  belongs_to :invited_by, class_name: 'User', optional: true

  after_initialize :set_defaults, unless: :persisted?
  before_save :remove_leading_trailing_whitespace

  validates :name, presence: true
  validates :locale, inclusion: {
    in: Rails.application.config.i18n.available_locales.map(&:to_s).push(nil)
  }

  def authenticatable_salt
    return super unless session_token

    "#{super}#{session_token}"
  end

  def invalidate_all_sessions!
    update_attribute(:session_token, SecureRandom.hex)
  end

  def active_for_authentication?
    super && !banned
  end

  def self.find_for_oauth(auth)
    user = find_or_initialize_by(email: auth.info.email)
    user.name ||= auth.info.name
    user.password ||= Devise.friendly_token[0, 20]
    update_access_token_fields(user:, access_token: auth)
    user
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider,
          uid: auth.provider + auth.uid).first_or_create do |user|
      UserBuilder::Builder.build(user:, auth:)
    end
  end

  def access_token
    access_token_expired? ? update_access_token : token
  end

  def oauth_enabled?
    token.present?
  end

  def remove_leading_trailing_whitespace
    @email&.strip!
    @name&.strip!
  end

  def set_defaults
    @comment_notify.nil? && @comment_notify = true
    @ally_notify.nil? && @comment_notify = true
    @group_notify.nil? && @comment_notify = true
    @meeting_notify.nil? && @comment_notify = true
  end

  def update_access_token
    params = { 'refresh_token' => refresh_token,
               'client_id' => ENV.fetch('GOOGLE_CLIENT_ID', nil),
               'client_secret' => ENV.fetch('GOOGLE_CLIENT_SECRET', nil),
               'grant_type' => 'refresh_token' }
    response = Net::HTTP.post_form(URI.parse(OAUTH_TOKEN_URL), params)
    decoded_response = JSON.parse(response.body)
    new_expiration_time = Time.zone.now + decoded_response['expires_in']
    new_access_token = decoded_response['access_token']
    update(token: new_access_token, access_expires_at: new_expiration_time)
    new_access_token
  end

  def build_csv_data
    user_data = [['user_info']]
    user_data << USER_DATA_ATTRIBUTES
    user_data << USER_DATA_ATTRIBUTES.map { |attribute| send(attribute.to_sym) }
    user_data += Group.build_csv_rows(groups)
    user_data += GroupMember.build_csv_rows(group_members)
    user_data += Category.build_csv_rows(categories)
    user_data += Medication.build_csv_rows(medications)
    user_data += Strategy.build_csv_rows(strategies)
    user_data += Moment.build_csv_rows(moments)
    user_data += Notification.build_csv_rows(notifications)
    user_data += Mood.build_csv_rows(moods)
    user_data += CarePlanContact.build_csv_rows(care_plan_contacts)
    user_data += Allyship.build_csv_rows(allyships)
    user_data += MeetingMember.build_csv_rows(meeting_members)
    user_data
  end

  def generate_data_request
    ActiveRecord::Base.transaction do
      lock!
      data_request = data_requests
                     .where(status_id: Users::DataRequest::STATUS[:enqueued])
                     .first_or_initialize
      if data_request.request_id.present?
        data_request.request_id
      else
        data_request.request_id = SecureRandom.uuid
        data_request.save!
      end
      data_request.request_id
    end
  end

  def delete_stale_data_file
    successful_data_requests = data_requests
                               .where(
                                 status_id: Users::DataRequest::STATUS[:success]
                               )
                               .order('updated_at desc')
    return if successful_data_requests.count < 2

    ActiveRecord::Base.transaction do
      stale_data_requests = successful_data_requests.where.not(
        id: successful_data_requests.first
      )
      stale_data_requests.each do |dr|
        File.delete(dr.file_path) if File.exist?(dr.file_path)
        dr.update!(status_id: Users::DataRequest::STATUS[:deleted])
      end
    end
  end

  private_class_method def self.update_access_token_fields(user:, access_token:)
    user.update!(
      provider: access_token.provider,
      token: access_token.credentials.token,
      refresh_token: access_token.credentials.refresh_token,
      uid: access_token.uid,
      access_expires_at: Time.zone.at(access_token.credentials.expires_at)
    )
  end

  private

  def oauth_provided?
    provider.present? || token.present?
  end

  def access_token_expired?
    !access_expires_at || Time.zone.now > access_expires_at
  end

  def confirmation_required?
    return false if oauth_provided?

    super
  end
end
