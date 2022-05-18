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

  describe "#to_param" do
    let(:article) {FactoryBot.build(:article, title: "Test Title")}

    context "given an Article that exists in the database" do
      it "returns the slug" do
        article.save

        expect(article.to_param).to eq(Article.first.slug)
      end
    end

    context "given an Article that don't exist in the database" do
      it "returns nil" do
        expect(article.to_param).to be_nil
      end
    end
  end

  context 'when Article body is sanitized' do
    it "blacklisted elements are removed" do
      html = "<script></script>"
  
      a = Article.new({:title => "Title", :body => html})
      a.valid?
  
      expect(a.errors.full_messages_for :body).to include("Body can't be blank")
      expect(a.body).to eq("")
    end
  
    it "allowlisted elements are not removed" do
      html = "<p>Heres is the Article body.</p>"
  
      a = Article.new({:title => "Title", :body => html})
      expect(a.valid?).to eq(true)
      expect(a.body).to eq("<p>Heres is the Article body.</p>")
    end
  end
end
