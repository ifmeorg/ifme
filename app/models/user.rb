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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  attr_accessible :timezone, :location, :email, :password, :password_confirmation, :remember_me, :name, :about, :avatar, :token, :uid, :provider

  mount_uploader :avatar, AvatarUploader

  before_save :remove_leading_trailing_whitespace

  has_many :allyships
  has_many :allies, through: :allyships

  def remove_leading_trailing_whitespace
  	self.email.rstrip!
  	self.email.lstrip!
  	self.name.rstrip!
  	self.name.lstrip!
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
	data = access_token.info
    user = User.find_by(email: data.email)
    if user
      user.provider = access_token.provider
      user.uid = access_token.uid
      user.token = access_token.credentials.token
      user.save
      user
    else
      fullname = data["name"]
      user = User.create(name: fullname, provider: access_token.provider, email: data["email"], uid: access_token.uid, password: Devise.friendly_token[0,20])
    end
   end

   def allies_by_status(status)
     allyships.includes(:ally).where(status: ALLY_STATUS[status]).map(&:ally)
   end
end
