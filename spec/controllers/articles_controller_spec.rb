require "rails_helper"

describe ArticlesController do
  let(:user) { create(:user) }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      sign_in user
      get :index
      expect(response).to be_ok
    end

    it "renders the index template" do
      sign_in user
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the articles into @articles" do
      sign_in user
      articles = create_list(:article, 2, user: user)
      get :index

      expect(assigns(:articles)).to match_array(articles)
    end
  end

  describe "GET #show" do
    it "shows new article" do
      sign_in user
      article = create(:article, user: user, text: "123")
      get :show, id: article.id

      expect(assigns(:article).id).to eq(article.id)
    end
  end

  describe "POST #create" do
    it "creates new article for current user" do
      sign_in user
      post :create, article: {title: "test article", text: "123"}
      article = Article.last

      expect(response).to redirect_to(article_path(article.id))
      expect(article.title).to eq("test article")
      expect(article.user).to eq(user)
    end

    it "does not create new article if validation failed" do
      sign_in user
      post :create, article: {title: "test", text: "123"}

      expect(response).to render_template("new")
      expect(assigns(:article).errors.keys).to include(:title)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the article and redirects to articles index page" do
      sign_in user
      article = create(:article, user: user)
      expect(Article.all.size).to be(1)
      delete :destroy, id: article.id

      expect(response).to redirect_to(articles_path)
      expect(Article.all).to be_empty
    end
  end

  describe "PUT #update" do
    it "update article" do
      sign_in user
      article = create(:article, user: user, title: "super title", text: "My text")
      put :update, id: article.id, article: {title: "NotTitle"}
      article.reload

      expect(article.title).to eq("NotTitle")
    end
  end

end