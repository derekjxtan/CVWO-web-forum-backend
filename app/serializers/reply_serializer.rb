class ReplySerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id, :likes, :dislikes, :reply_id, :replies_count, :created_at, :updated_at

  # reference back user and parent post
  has_one :user, Serializer: UserSerializer
  has_one :post, Serializer: PostSerializer
end
