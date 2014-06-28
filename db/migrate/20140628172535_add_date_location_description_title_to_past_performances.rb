class AddDateLocationDescriptionTitleToPastPerformances < ActiveRecord::Migration
  def change
    add_column :past_performances, :date, :datetime
    add_column :past_performances, :location, :text
    add_column :past_performances, :description, :text
    add_column :past_performances, :title, :string
  end
end
