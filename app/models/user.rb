class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics
  has_many :posts

  def photo_url
    return 'https://res.cloudinary.com/ddbkhb3vl/image/upload/v1554198140/user-avatar-placeholder_rbjvlt.png'
  end

end
