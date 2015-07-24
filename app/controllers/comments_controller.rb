class CommentsController < ApplicationController
  before_action :find_article, only: [:create, :destroy]
  before_action :find_comment_and_validate_author, only: [:destroy]

  def create
    @comment = @article.comments.create({user_id: current_user.id}.merge(comment_params))
    redirect_to article_path(@article)
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_comment_and_validate_author
    @comment = @article.comments.find(params[:id])
    unless @comment.owned_by?(current_user) || @article.owned_by?(current_user)
      flash[:alert] = 'You are not an owner of this comment'
      redirect_to article_path(@article)
    end
  end
end
