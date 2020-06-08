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
#

class User < ApplicationRecord
  include PasswordValidator
  include AllyConcern

  OAUTH_TOKEN_URL = 'https://accounts.google.com/o/oauth2/token'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :uid,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: %i[google_oauth2 facebook]

  mount_uploader :avatar, AvatarUploader

  has_many :allyships
  has_many :allies, through: :allyships
  has_many :group_members, foreign_key: :user_id
  has_many :groups, through: :group_members
  has_many :meeting_members, foreign_key: :user_id
  has_many :medications, foreign_key: :user_id
  has_many :strategies
  has_many :notifications, foreign_key: :user_id
  has_many :moods
  has_many :moments
  has_many :categories
  has_many :care_plan_contacts
  has_many :password_histories, dependent: :destroy
  belongs_to :invited_by, class_name: 'User'

  after_initialize :set_defaults, unless: :persisted?
  before_save :remove_leading_trailing_whitespace
  after_save :create_password_history

  validates :name, presence: true
  validates :locale, inclusion: {
    in: Rails.application.config.i18n.available_locales.map(&:to_s).push(nil)
  }
  validate :password_complexity, unless: :oauth_provided?

  def active_for_authentication?
    super && !banned
  end

  def self.find_for_oauth(auth)
    user = find_or_initialize_by(email: auth.info.email)
    user.name ||= auth.info.name
    user.password ||= Devise.friendly_token[0, 20]
    update_access_token_fields(user: user, access_token: auth)
    user
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider,
          uid: auth.provider + auth.uid).first_or_create do |user|
      UserBuilder::Builder.build(user: user, auth: auth)
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
               'client_id' => ENV['GOOGLE_CLIENT_ID'],
               'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
               'grant_type' => 'refresh_token' }
    response = Net::HTTP.post_form(URI.parse(OAUTH_TOKEN_URL), params)
    decoded_response = JSON.parse(response.body)
    new_expiration_time = Time.zone.now + decoded_response['expires_in']
    new_access_token = decoded_response['access_token']
    update(token: new_access_token, access_expires_at: new_expiration_time)
    new_access_token
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
end
