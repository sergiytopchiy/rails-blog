class CommentsController < ApplicationController
  before_action :find_article, only: [:create, :destroy]
  before_action :find_comment_and_validate_author, only: [:destroy]

  def create #this method is creating new comment to article
    @comment = @article.comments.create({user_id: current_user.id}.merge(comment_params))
    redirect_to article_path(@article) # merge is connect two hashes (user id and comment params)
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_article #finding current article by :article_id
    @article = Article.find(params[:article_id])
  end

  def find_comment_and_validate_author
    @comment = @article.comments.find(params[:id]) # finding comment and set it into variable
    unless @comment.owned_by?(current_user) || @article.owned_by?(current_user)
      # if current user is not an owner of this article or comment, redirecting to current article
      redirect_to article_path(@article), alert: I18n.t('errors.not_an_owner_of_comment')
    end
  end
end
