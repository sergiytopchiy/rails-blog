require "rails_helper"

describe CommentsController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "POST #create" do
    it "creates new comment for current user" do
      article = create(:article)
      post :create, comment: {body: "test article"}, article_id: article.id
      comment = Comment.last

      expect(response).to redirect_to(article_path(article.id))
      expect(comment.body).to eq("test article")
      expect(comment.user_id).to eq(user.id)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the comment from comments by author of comment" do
      article = create(:article)
      comment = create(:comment, user: user, article: article)
      expect(article.comments.size).to be(1)
      delete :destroy, article_id: article.id, id: comment.id

      expect(response).to redirect_to(article_path(article.id))
      expect(article.comments).to be_empty
    end

    it "deletes the comment from comments by author of article" do
      article = create(:article, user: user)
      comment = create(:comment, article: article)
      expect(article.comments.size).to be(1)
      delete :destroy, article_id: article.id, id: comment.id

      expect(response).to redirect_to(article_path(article.id))
      expect(article.comments).to be_empty
    end

    it "try to delete comment by not an author of article and not" do
      article = create(:article)
      comment = create(:comment, article: article)
      expect(article.comments.size).to be(1)
      delete :destroy, article_id: article.id, id: comment.id

      expect(response).to redirect_to(article_path(article.id))
      expect(article.comments).to_not be_empty
      expect(flash[:alert]).to eq("You are not an owner of this comment")
    end
  end
end
