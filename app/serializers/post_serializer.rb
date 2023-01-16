class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :categories, :user_id, :likes, :dislikes, :saves, :created_at, :updated_at

  # references back user
  belongs_to :user, Serializer: UserSerializer
  # references replies
  has_many :replies
  # has_many :likes
  # has_many :dislikes
  # has_many :saves
end
