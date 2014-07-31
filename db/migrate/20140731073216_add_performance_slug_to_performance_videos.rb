class AddPerformanceSlugToPerformanceVideos < ActiveRecord::Migration
  def change
    add_column :performance_videos, :performance_slug, :string
  end
end
