class ArticlesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @articles =Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments
  end

  def new
    @article = current_user.articles.build
  end
  
  def create
     @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: 'Successfully　created'
    else
      render :new
    end
  end

  def edit
     @article = current_user.articles.find(params[:id])
  end
  
  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'Successfully　updated'
    else
      render :edit
    end
  end
  
  def destroy
     article = current_user.articles.find(params[:id])
     article.destroy!
     redirect_to articles_path, notice: 'Successfully　deleted'
  end
  
  
  private
  def article_params
    params.require(:article).permit(:title, :content)
  end
end
