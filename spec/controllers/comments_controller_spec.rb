require "rails_helper"

describe CommentsController do
  let(:user) { create(:user) }

  describe "POST #create" do
    it "creates new comment for current user" do
      sign_in user
      article = create(:article)
      post :create, comment: {body: "test article"}, article_id: article.id
      comment = Comment.last

      expect(response).to redirect_to(article_path(article.id))
      expect(comment.body).to eq("test article")
      expect(comment.user_id).to eq(user.id)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the comment from comments" do
      sign_in user
      article = create(:article)
      comment = create(:comment, user: user, article: article)
      expect(article.comments.size).to be(1)
      delete :destroy, article_id: article.id, id: comment.id

      expect(response).to redirect_to(article_path(article.id))
      expect(article.comments).to be_empty
    end
  end
end