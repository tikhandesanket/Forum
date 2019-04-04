class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #:lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics
  has_many :posts

  def photo_url
    return 'https://res.cloudinary.com/ddbkhb3vl/image/upload/v1554198140/user-avatar-placeholder_rbjvlt.png'
  end

  def after_confirmation
  	UserMailer.welcome(self).deliver_now
  end

end
