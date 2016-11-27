# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  location               :string(255)
#  timezone               :string(255)
#  about                  :text
#  avatar                 :string(255)
#  conditions             :text
#  token                  :string(255)
#  uid                    :string(255)
#  provider               :string(255)
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

  validates :name, presence: { message: "must be given please" }

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
