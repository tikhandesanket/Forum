class Topic < ApplicationRecord

	extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :posts

  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :name, presence: true

end
