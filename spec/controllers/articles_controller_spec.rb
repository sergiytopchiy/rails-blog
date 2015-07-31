require "rails_helper"

describe ArticlesController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_ok
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template("index")
    end

    it "loads all of the articles into @articles" do
      articles = create_list(:article, 2, user: user)
      get :index

      expect(assigns(:articles)).to match_array(articles)
    end
  end

  describe "GET #show" do
    it "shows new article" do
      article = create(:article, user: user)
      get :show, id: article.id

      expect(assigns(:article).id).to eq(article.id)
    end
  end

  describe "POST #create" do
    it "creates new article for current user" do
      post :create, article: {title: "test article", text: "123"}
      article = Article.last

      expect(response).to redirect_to(article_path(article.id))
      expect(article.title).to eq("test article")
      expect(article.user).to eq(user)
    end

    it "does not create new article if validation failed" do
      post :create, article: {title: "test", text: "123"}

      expect(response).to render_template("new")
      expect(assigns(:article).errors.keys).to include(:title)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the article and redirects to articles index page" do
      article = create(:article, user: user)
      expect(Article.all.size).to be(1)
      delete :destroy, id: article.id

      expect(response).to be_success
      expect(Article.all).to be_empty
    end

    it "does not delete article if user is not author" do
      article = create(:article)
      expect(Article.all.size).to be(1)
      delete :destroy, id: article.id

      expect(response).to redirect_to(articles_path)
      expect(flash[:alert]).to eq("You are not an owner")
      expect(Article.all).to_not be_empty
    end
  end

  describe "PUT #update" do
    let(:article) { create(:article, user: user, title: "super title", text: "My text") }

    it "update article" do
      put :update, id: article.id, article: {title: "NotTitle"}
      article.reload

      expect(response).to redirect_to(article_path(article.id))
      expect(article.title).to eq("NotTitle")
    end

    it "does not update article if validation failed" do
      put :update, id: article.id, article: {title: "No"}
      article.reload

      expect(response).to render_template("edit")
      expect(article.title).to eq("super title")
    end

    it "does not update article if user is not author" do
      article = create(:article, title: "super title")
      put :update, id: article.id, article: {title: "NotTitle"}
      article.reload

      expect(response).to redirect_to(articles_path)
      expect(flash[:alert]).to eq("You are not an owner")
      expect(article.title).to eq("super title")
    end
  end
end
