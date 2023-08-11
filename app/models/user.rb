class User < ApplicationRecord
  belongs_to :profile
  has_secure_password

  validates :email, uniqueness: true
end
