require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /articles" do
    let!(:article) {FactoryBot.create(:article, title: "Test Title")}
    
    it "responds with article and status code 200" do
      get articles_path

      body = CGI.unescapeHTML(response.body)

      expect(body).to include(Article.first.title && Article.first.body.truncate_words(15))
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /articles/new" do
    it "responds with a success status" do
      get new_article_path

      expect(response).to have_http_status(200)
    end
  end

  describe "GET /articles/:id" do
    let(:article) {FactoryBot.create(:article, title: "Test Title")}

    context "when supplied with the slug" do
      it "responds with correct article and status code 200" do
        get article_path(article.slug)

        body = CGI.unescapeHTML(response.body)

        expect(body).to include(Article.first.title && Article.first.body)
        expect(response).to have_http_status(200)
      end
    end

    context "when supplied with the id" do
      it "responds with correct article and status code 200" do
        get article_path(article.id)

        body = CGI.unescapeHTML(response.body)

        expect(body).to include(Article.first.title)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /articles" do
    context "with valid attributes" do 
      it "successfully adds the article and redirects with status code of 302" do
        expect{post articles_path, :params => {:article => {:title => "This is the new title", :body => "And here is a new body!"}}}.to change{Article.count}.by(1)

        expect(response).to have_http_status(302)
      end
    end

    context "with invalid attributes" do
      it "responds with status code 422 when title is nil" do
        post articles_path, :params => {:article => {:title => nil, :body => "Hey! Where's the title??"}}

        expect(response).to have_http_status(422)
      end

      it "responds with status code 422 when body is nil" do
        post articles_path, :params => {:article => {:title => "Hey! Now we're missing the body!", :body => nil}}

        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /articles/:id" do
    let(:article) {FactoryBot.create(:article)}

    it "redirects after successfully updating article" do
      put "/articles/#{article.id}", :params => {:article => {:title => "This is a new title", :body => "And heres a new body!"}}

      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE /articles/:id" do
    let!(:article) {FactoryBot.create(:article)}

    it "decreases Articles count by 1 and responds with status 303" do
      expect{delete article_path(article)}.to change{Article.count}.by(-1)
      expect(response).to have_http_status(303)
    end
  end
end
