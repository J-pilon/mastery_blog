class Profile < ApplicationRecord
  has_one :user

  validates :first_name, :last_name, presence: true
end
