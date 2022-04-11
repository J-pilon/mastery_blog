FactoryBot.define do
  factory :article do
    title { LiterateRandomizer.sentence(:words => 5) }
    body { LiterateRandomizer.paragraph(:sentences => 8) }
  end
end
