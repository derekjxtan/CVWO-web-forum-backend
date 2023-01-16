class UserSerializer < ActiveModel::Serializer
  # Do not send password to front end
  attributes :id, :username

  # references posts and replies
  has_many :posts
  has_many :replies

  has_many :liked
  has_many :disliked
  has_many :saved

  has_many :liked_r
  has_many :disliked_r
end
