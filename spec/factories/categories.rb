FactoryBot.define do
  categories = [
    'Technology',
    'Health & Wellness',
    'Food & Recipes',
    'Travel',
    'Fashion & Style',
    'Science',
    'Business & Finance',
    'Sports & Fitness',
    'Arts & Culture',
    'Lifestyle'
  ]

  factory :category do
    name { categories.sample }

    initialize_with do
      Category.find_or_create_by(name: name)
    end
  end
end
