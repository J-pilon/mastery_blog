FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }

    association :profile
  end
end