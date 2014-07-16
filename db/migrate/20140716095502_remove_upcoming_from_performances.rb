class RemoveUpcomingFromPerformances < ActiveRecord::Migration
  def change
    remove_column :performances, :upcoming, :boolean
  end
end
