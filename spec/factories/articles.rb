FactoryBot.define do
  factory :article do
    title { LiterateRandomizer.sentence(words: 5) }
    body { LiterateRandomizer.paragraphs(paragraphs: 3, sentences: 10) }

    association :category
    # category do
    #   Category.find_by(name: 'Technology') || FactoryBot.create(:category, name: 'Technology')
    # end
  end
end
