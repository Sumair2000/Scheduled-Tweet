# email: string
# password: string
# 
# password: string (virtual)
# password_confirmation (virtual)
class User < ApplicationRecord
  before_create :confirmation_token
  
  has_many :twitter_accounts
  has_secure_password
  has_many :tweets
  validates :email, uniqueness: :true ,format: {with: /\A[^@\s]+@[^@\s]+\z/ , message: "Must be a valid email address."}
  validates :username, presence: true ,format: {with: /([\w\-\']{2,})([\s]+)([\w\-\']{2,})/ , message: "Must be a valid name"}

  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false) 
  end
 
end
