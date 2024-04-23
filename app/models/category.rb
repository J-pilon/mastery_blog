class Category < ApplicationRecord
  has_many :articles
  enum category: {
    technology: "Technology",
    health_wellness: "Health & Wellness",
    food_recipes: "Food & Recipes",
    travel: "Travel",
    fashion_style: "Fashion & Style",
    science: "Science",
    business_finance: "Business & Finance",
    sports_fitness: "Sports & Fitness",
    arts_culture: "Arts & Culture",
    lifestyle: "Lifestyle"
  }
  validates :name, presence: true, uniqueness: true, inclusion: { in: categories.values }
end
