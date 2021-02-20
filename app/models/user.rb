# email: string
# password: string
# 
# password: string (virtual)
# password_confirmation (virtual)
class User < ApplicationRecord

  has_many :twitter_accounts
  has_secure_password
  has_many :tweets
  validates :email, uniqueness: :true ,format: {with: /\A[^@\s]+@[^@\s]+\z/ , message: "Must be a valid email address."}

end
