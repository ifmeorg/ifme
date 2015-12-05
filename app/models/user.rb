class User < ActiveRecord::Base
  ALLY_STATUS = {
    ACCEPTED: 0,
    PENDING_FROM_USERID1: 1,
    PENDING_FROM_USERID2: 2
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

   def accepted_allies
     allyships.includes(:ally).where(status: ALLY_STATUS[:ACCEPTED]).map(&:ally)
   end
end
