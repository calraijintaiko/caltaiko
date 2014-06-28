class AddDateLocationDescriptionTitleToUpcomingPerformances < ActiveRecord::Migration
  def change
    add_column :upcoming_performances, :date, :datetime
    add_column :upcoming_performances, :location, :text
    add_column :upcoming_performances, :description, :text
    add_column :upcoming_performances, :title, :string
  end
end
