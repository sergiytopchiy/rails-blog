class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :validate_author, only: [:edit, :update, :destroy]
  #before_action :layout, only: [:edit, :new]
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10).order("created_at DESC").includes(:user) #just assign to instanse variable all of articles values
  end

  def new
    @article = Article.new
    @categories = @article.categories.all
  end

  def edit
    @categories = @article.categories.all
  end

  def create
    @article = Article.new(article_params) #Create new aticle with two parameters: title, text
    @article.user_id = current_user.id #Adding to aticles column value of cuurent user id

    if @article.save #if saving of article is correct, it will return true
      redirect_to @article #and will redirect to saved article
    else
      render 'new' # if saving is not correct - it will render a new form
    end
  end

  def update # first the before action will find cuurent article by id (before action)
    if @article.update(article_params) #then, if updating of article is successful
      redirect_to @article #it will redirect us to current article page
    else
      render 'edit' # else, page of article editing will render again
    end
  end

  def destroy #if we want to destroy some article, we must to know article id
    @article.destroy # this line is calling destroy method from current article
    head 204 #and redirecting to articles
  end

  private

  def article_params # this method need to say what columns we want to change
    params.require(:article).permit(:title, :text)
  end

  def find_article #this article returns result of finding current articles ID
    @article = Article.find(params[:id])
  end

  def validate_author #this method need to chek if current user is owner of article
    unless @article.owned_by?(current_user)
      redirect_to articles_path, alert: I18n.t('errors.not_an_owner')
    end
  end

  def layout
    render layout: "form" 
    
  end

end
