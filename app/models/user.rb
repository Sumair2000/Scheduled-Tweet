# email: string
# password: string
# 
# password: string (virtual)
# password_confirmation (virtual)
class User < ApplicationRecord
  has_secure_password
end
