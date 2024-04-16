# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# FactoryBot.create_list(:article, 50)


# create users with profiles using FactoryBot
10.times do
  user = FactoryBot.create(:user)
  user.save
end

# create an article for each user
Profile.all.each do |profile|
  FactoryBot.create(:article, profile: profile)
end

