class ArticlesController < ApplicationController
  include Pagination

  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @pagination, @articles = paginate(collection: Article.all.order(created_at: :desc),
                                      params: remedy_page_param(page_params))
  end

  def show
    @article = find_article(params[:id])
  end

  def new
    current_categories
    @article = Article.new
  end

  def create
    @article = current_profile.articles.build(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    current_categories
    @article = find_article(params[:id])
    is_unauthorized?(@article, 'show')
  end

  def update
    @article = find_article(params[:id])
    return if is_unauthorized?(@article, 'show')

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = find_article(params[:id])
    return if is_unauthorized?(@article, 'show')

    @article.destroy

    redirect_to articles_path, status: :see_other
  end

  def publish
    article = find_article(params[:id])
    state_machine_article = StateMachine::Article.new(article)
    state_machine_article.publishing!
    redirect_to article_path(article) if article.save
  end

  def index_by_category
    @category = Category.find(category_params[:category_id])
    @pagination, @articles = paginate(collection: @category.articles.order(created_at: :desc),
                                      params: remedy_page_param(page_params))
    render :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image_url, :category_id)
  end

  def page_params
    params.permit(:page, :per_page)
  end

  def category_params
    params.permit(:category_id)
  end

  def find_article(id)
    id.to_i == 0 ? Article.find_by(slug: id) : Article.find(id)
  end

  def remedy_page_param(params)
    params[:page] = 1 if params[:page].to_i == 0

    params
  end

  def is_unauthorized?(article, destination)
    destination = destination.to_sym
    return unless article.profile.id != current_profile.id

    render destination, status: :unauthorized
    true
  end
end
