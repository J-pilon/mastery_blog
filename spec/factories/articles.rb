FactoryBot.define do
  factory :article do
    title { LiterateRandomizer.sentence(words: 5) }
    body { LiterateRandomizer.paragraphs(paragraphs: 3, sentences: 10) }
  end
end
