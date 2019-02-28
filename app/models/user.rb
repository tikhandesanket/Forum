class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics
  has_many :posts

  def photo_url
    return 'http://res.cloudinary.com/ddbkhb3vl/image/asset/v1517130970/default-f923b61d87de05d96ee32141d21c6e68.png'
  end

end
