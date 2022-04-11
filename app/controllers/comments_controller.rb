class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params) 
    @comment.user_id = current_user.id 
    if @comment.save
      render :index #④
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :index #⑥
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
