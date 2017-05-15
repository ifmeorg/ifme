# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
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
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  comment_notify         :boolean
#  ally_notify            :boolean
#  group_notify           :boolean
#  meeting_notify         :boolean
#  locale                 :string
#

class User < ActiveRecord::Base
  ALLY_STATUS = {
    accepted: 0,
    pending_from_user: 1,
    pending_from_ally: 2
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :uid,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  mount_uploader :avatar, AvatarUploader

  before_save :remove_leading_trailing_whitespace

  has_many :allyships
  has_many :allies, through: :allyships
  has_many :alerts, inverse_of: :user
  has_many :group_members, foreign_key: :userid
  has_many :groups, through: :group_members
  has_many :meeting_members, foreign_key: :userid
  has_many :medications, foreign_key: :userid
  has_many :strategies, foreign_key: :userid
  has_many :notifications, foreign_key: :userid
  after_initialize :set_defaults, unless: :persisted?

  validates :name, presence: true
  validates :locale, inclusion: { in: [nil, "en", "es"] }

  def remove_leading_trailing_whitespace
    @email&.strip!
    @name&.strip!
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = find_or_initialize_by(email: data.email) do |user|
      user.name = data.name
      user.password = Devise.friendly_token[0,20]
    end

    user.update!(
        provider: access_token.provider,
        token: access_token.credentials.token,
        uid: access_token.uid,
      )
    user
  end

   def allies_by_status(status)
     allyships.includes(:ally).where(status: ALLY_STATUS[status]).map(&:ally)
   end

   def set_defaults
     @comment_notify.nil? && @comment_notify = true
     @ally_notify.nil? && @comment_notify = true
     @group_notify.nil? && @comment_notify = true
     @meeting_notify.nil? && @comment_notify = true
   end


   def available_groups(order)
     ally_groups.order(order) - groups
   end

   def google_oauth2_enabled?
     !token.blank?
   end

   private

   def accepted_ally_ids
     allyships.where(status: ALLY_STATUS[:accepted]).pluck(:ally_id)
   end

   def ally_groups
     Group.includes(:group_members)
           .where(group_members: { userid: accepted_ally_ids })
   end
end
