class User < ActiveRecord::Base
  has_many :comments
  has_many :posts
  has_many :post_votes
  has_many :comment_votes
end
