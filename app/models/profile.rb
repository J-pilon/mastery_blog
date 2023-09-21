class Profile < ApplicationRecord
  has_one :user
  has_many :articles

  validates :first_name, :last_name, presence: true
end
