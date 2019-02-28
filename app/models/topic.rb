class Topic < ApplicationRecord

	extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  belongs_to :user
  has_many :posts

  accepts_nested_attributes_for :posts, allow_destroy: true

  validates :name, presence: true

end
