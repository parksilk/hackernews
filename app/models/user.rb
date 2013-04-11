require 'bcrypt'

class User < ActiveRecord::Base
  has_many :comments
  has_many :posts
  has_many :post_votes
  has_many :comment_votes

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    puts "*" * 100
    puts "setting password using BCrypt!"
    @password = Password.create(new_password)
    self.password_hash = @password
  end


end
