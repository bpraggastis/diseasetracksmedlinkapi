class User < ActiveRecord::Base
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, on: :create, on: :update
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  
end
