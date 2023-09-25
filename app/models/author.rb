class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_one :user
  has_many :articles
end
