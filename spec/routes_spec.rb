require 'rails_helper'

describe "routing for articles", type: :routing do

  it "routes /articles" do
    expect(get: "/articles").to route_to(controller: "articles", action: "index")
    expect(post: "/articles").to route_to(controller: "articles", action: "create")
  end

  it "routes /articles/:id" do
    expect(get: "/articles/42").to route_to(controller: "articles", action: "show", id: "42")
    expect(put: "/articles/42").to route_to(controller: "articles", action: "update", id: "42")
    expect(delete: "/articles/42").to route_to(controller: "articles", action: "destroy", id: "42")
  end

end

describe "routing for comments", type: :routing do

  it "routes /articles/:article_id/comments" do
    expect(post: "/articles/42/comments").to route_to(controller: "comments", action: "create", article_id: "42")
  end

  it "routes /articles/:article_id/comments/:id" do
    expect(delete: "/articles/42/comments/3").to route_to(controller: "comments", action: "destroy", article_id: "42", id: "3")
  end

end