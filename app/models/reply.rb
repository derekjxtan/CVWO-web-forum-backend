class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :reply, optional: true

  has_many :liked_replies, :dependent => :destroy
  has_many :disliked_replies, :dependent => :destroy
  has_many :reply, :dependent => :destroy

  # check body
  validates :body, presence: true
end
