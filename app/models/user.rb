class User < ApplicationRecord
  belongs_to :profile
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def generate_reset_token
    token = SecureRandom.uuid
    self.reset_token = token
    self.reset_token_expiry = DateTime.now + 30.minutes
  end

  def is_reset_token_valid?
    DateTime.now < self.reset_token_expiry
  end
end
