class RemovePerformanceIdFromPerformanceVideos < ActiveRecord::Migration
  def change
    remove_column :performance_videos, :performance_id, :integer
  end
end
