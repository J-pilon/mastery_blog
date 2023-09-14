class User < ApplicationRecord
  belongs_to :profile
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
