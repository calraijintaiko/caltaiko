class CreateUpcomingPerformances < ActiveRecord::Migration
  def change
    create_table :upcoming_performances do |t|

      t.timestamps
    end
  end
end
