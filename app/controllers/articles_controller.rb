class ArticlesController < ApplicationController
  include Pagination

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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
    @state_machine = StateMachine::Article.new(@article.state)
    # StateMachine::Article.transition(@article)
    next_state = @state_machine.transition
    article_params.merge(state: :next_state)
    @article = current_profile.articles.build(article_params)


    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = find_article(params[:id])
    is_unauthorized?(@article, "show")
  end

  def update
    @article = find_article(params[:id])
    return if is_unauthorized?(@article, "show")
    @state_machine = StateMachine::Article.new(@article)

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = find_article(params[:id])
    return if is_unauthorized?(@article, "show")
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

  def is_unauthorized?(article, destination)
    destination = destination.to_sym
    if article.profile.id != current_profile.id
      render destination, status: :unauthorized
      return true
    end
  end
end
