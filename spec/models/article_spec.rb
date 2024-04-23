require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:profile) { FactoryBot.create(:profile) }

  describe 'is valid' do
    it 'when title and body are present' do
      article = FactoryBot.build(:article, profile: profile)

      expect(article).to be_valid
    end
  end

  describe 'is invalid' do
    context 'when title' do
      let(:article) { FactoryBot.build(:article, title: nil) }

      it 'is nil' do
        article.valid?

        expect(article.errors.full_messages_for(:title)).to include("Title can't be blank")
      end
    end

    context 'when body' do
      let(:article) { FactoryBot.build(:article, body: nil) }

      it 'is nil' do
        article.valid?

        expect(article.errors.full_messages_for(:body)).to include("Body can't be blank")
      end
    end
  end

  describe '#to_param' do
    let(:article) { FactoryBot.build(:article, title: 'Test Title', profile: profile) }

    context 'given an Article that exists in the database' do
      it 'returns the slug' do
        article.save
        expect(article.to_param).to eq(Article.first.slug)
      end
    end

    context "given an Article that don't exist in the database" do
      it 'returns nil' do
        expect(article.to_param).to be_nil
      end
    end
  end

  context 'when Article body is sanitized' do
    it 'blacklisted elements are removed' do
      html = '<script></script>'

      article = FactoryBot.build(:article, title: 'Title', body: html)
      article.valid?

      expect(article.errors.full_messages_for(:body)).to include("Body can't be blank")
      expect(article.body).to eq('')
    end

    it 'allowlisted elements are not removed' do
      html = '<p>Heres is the Article body.</p>'

      article = FactoryBot.build(:article, title: 'Title', body: html, profile: profile,
                                           category: FactoryBot.create(:category))
      expect(article.valid?).to eq(true)
      expect(article.body).to eq(' Heres is the Article body. ')
    end
  end
end
