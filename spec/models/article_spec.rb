require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "is valid" do
    it "when title and body are present" do
      article = FactoryBot.build(:article)

      expect(article).to be_valid
    end
  end

  describe "is invalid" do
    context "when title" do
      let(:article) {FactoryBot.build(:article, title: nil)}

      it "is nil" do
        article.valid?
        
        expect(article.errors.full_messages_for(:title)).to include("Title can't be blank")
      end
    end

    context "when body" do
      let(:article) {FactoryBot.build(:article, body: nil)}

      it "is nil" do
        article.valid?

        expect(article.errors.full_messages_for(:body)).to include("Body can't be blank")
      end
    end
  end
end
