class CreatePerformanceVideos < ActiveRecord::Migration
  def change
    create_table :performance_videos do |t|
      t.string :title
      t.string :link
      t.belongs_to :performance, index: true

      t.timestamps
    end
  end
end
