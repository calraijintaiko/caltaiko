class AddPublishedToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :published, :boolean, default: false
  end
end
