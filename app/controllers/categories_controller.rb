class CategoriesController < ApplicationController
  def create
    @category = Category.find(params[:id])
    @category.articles << Article.all.find(params[:article_id])
  end
end
