json.(@article, :title, :text, :created_at)
json.author @article.user.name
# json.comments @article.comments, :body, :created_at
json.comments do
  json.array! @article.comments do |comment|
    json.(comment, :body, :created_at)
    json.author comment.user.name
  end
end
