json.array!(@articles) do |article|
  json.extract! article, :id, :title, :date, :text, :current
  json.url article_url(article, format: :json)
end
