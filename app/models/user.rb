class User < ApplicationRecord
    has_secure_password

    has_many :posts, :dependent => :destroy
    has_many :replies, :dependent => :destroy

    has_many :liked_posts, :dependent => :destroy
    has_many :disliked_posts, :dependent => :destroy
    has_many :saved_posts, :dependent => :destroy
    has_many :liked, through: :liked_posts, source: :post, :dependent => :destroy
    has_many :disliked, through: :disliked_posts, source: :post, :dependent => :destroy
    has_many :saved, through: :saved_posts, source: :post, :dependent => :destroy

    has_many :liked_replies, :dependent => :destroy
    has_many :disliked_replies, :dependent => :destroy
    has_many :liked_r, through: :liked_replies, source: :reply, :dependent => :destroy
    has_many :disliked_r, through: :disliked_replies, source: :reply, :dependent => :destroy

    # check username and passward
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :password, presence: true
end
