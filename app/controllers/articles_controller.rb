class ArticlesController < ApplicationController
  
  include Pagination

  def index
    @pagination, @articles = paginate(collection: Article.all.order(created_at: :desc), params: remedy_page_param(page_params))
  end

  def show
    @article = find_article(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = find_article(params[:id])
  end

  def update
    @article = find_article(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = find_article(params[:id])
    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image_url)
  end

  def page_params
    params.permit(:page, :per_page)
  end

  def find_article id
    id.to_i == 0 ? Article.find_by(slug: id) : Article.find(id)
  end

  def remedy_page_param params
    if (params[:page].to_i) == 0
        params[:page] = 1
    end

    params
  end
end
