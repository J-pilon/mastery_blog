class User < ApplicationRecord
  belongs_to :profile
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def generate_reset_token
    update(reset_token_expiry: token_time_limit, reset_token: token)
  end

  def is_reset_token_valid?
    DateTime.now < reset_token_expiry
    # should the token be reset after checking
  end

  private

  def token
    SecureRandom.uuid
  end

  def token_time_limit
    DateTime.now + 5.minutes
  end
end
