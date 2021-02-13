# email: string
# password: string
# 
# password: string (virtual)
# password_confirmation (virtual)
class User < ApplicationRecord

  has_many :twitter_accounts
  has_secure_password
  has_many :tweets

end
