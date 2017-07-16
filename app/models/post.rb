class Post < ApplicationRecord

  belongs_to :user
  belongs_to :topic

  validate :body
end
