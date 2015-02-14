class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :timezone, :location, :username, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :about, :avatar

  mount_uploader :avatar, AvatarUploader
end
