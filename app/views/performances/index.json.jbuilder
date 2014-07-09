json.array!(@performances) do |performance|
  json.extract! performance, :id, :date, :title, :location, :description, :upcoming
  json.url performance_url(performance, format: :json)
end
