json.array!(@performance_videos) do |performance_video|
  json.extract! performance_video, :id, :title, :link, :performance_id
  json.url performance_video_url(performance_video, format: :json)
end
