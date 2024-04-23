require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    post sessions_path, params: { user: { email: user.email, password: user.password } }
  end

  describe 'GET /articles' do
    it 'responds with :ok status' do
      get articles_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /articles/new' do
    it 'responds with :ok status' do
      get new_article_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /articles/:id' do
    let(:profile) { FactoryBot.create(:profile) }
    let(:article) { FactoryBot.create(:article, title: 'Test Title', profile: profile) }

    it 'responds with :ok status when supplied slug' do
      get article_path(article.slug)
      expect(response).to have_http_status(:ok)
    end

    it 'responds with :ok status when supplied id' do
      get article_path(article.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /articles' do
    let!(:profile) { FactoryBot.create(:profile) }
    let!(:category) { FactoryBot.create(:category) }
    let(:valid_params) { { article: { title: 'title', body: 'body', category_id: category.id } } }

    context 'with valid params' do
      it 'responds with status 302' do
        post articles_path, params: valid_params
        expect(response).to have_http_status(302)
      end

      it 'increases Articles count by 1' do
        expect { post articles_path, params: valid_params }.to change { Article.count }.by(1)
      end
    end

    context 'with invalid params' do
      it 'responds with :unprocessable_entity status when title is nil' do
        post articles_path, params: { article: { title: nil, body: 'body', category_id: category.id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'responds with :unprocessable_entity status when body is nil' do
        post articles_path, params: { article: { title: 'title', body: nil, category_id: category.id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user isn\'t authenticated' do
      it 'responds with status 302' do
        post signout_path

        post articles_path, params: { article: { title: 'title', body: nil, category_id: category.id } }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /articles/:id/edit' do
    let(:article) { FactoryBot.create(:article, profile: user.profile) }

    it 'responds with status 200' do
      get edit_article_path(article)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /articles/:id' do
    let(:article) { FactoryBot.create(:article, profile: user.profile) }
    let(:put_article) do
      put "/articles/#{article.slug}", params: { article: { title: 'new title', body: 'new body' } }
    end

    it 'responds with status 302' do
      put_article
      expect(response).to have_http_status(302)
    end

    context 'when unauthorized' do
      let!(:second_user) { FactoryBot.create(:user) }

      it 'responds with status 401' do
        post signout_path
        post sessions_path, params: { user: { email: second_user.email, password: second_user.password } }

        put_article
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /articles/:id' do
    let!(:article) { FactoryBot.create(:article, profile: user.profile) }

    context 'when authorized' do
      it 'responds with :see_other status' do
        delete article_path(article)
        expect(response).to have_http_status(:see_other)
      end

      it 'reduces Articles count by 1' do
        expect { delete article_path(article) }.to change { Article.count }.by(-1)
      end
    end

    context 'when unauthorized' do
      let!(:second_user) { FactoryBot.create(:user) }
      let(:signin_as_second_user) do
        post signout_path
        post sessions_path, params: { user: { email: second_user.email, password: second_user.password } }
      end

      it 'responds with 401 status' do
        signin_as_second_user
        delete article_path(article)
        expect(response).to have_http_status(401)
      end

      it 'Articles count changes by 0' do
        signin_as_second_user
        expect { delete article_path(article) }.to change { Article.count }.by(0)
      end
    end
  end
end
