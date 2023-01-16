class Post < ApplicationRecord
  belongs_to :user
  has_many :replies, :dependent => :destroy
  has_many :liked_posts, :dependent => :destroy
  has_many :disliked_posts, :dependent => :destroy
  has_many :saved_posts, :dependent => :destroy

  # check title and body
  validates :title, presence: true
  validates :body, presence: true
end
