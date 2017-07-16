class Topic < ApplicationRecord

  belongs_to :user
  has_many :posts

  accepts_nested_attributes_for :posts, allow_destroy: true

  validate :name

end
