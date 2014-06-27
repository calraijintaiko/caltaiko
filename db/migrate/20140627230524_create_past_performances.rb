class CreatePastPerformances < ActiveRecord::Migration
  def change
    create_table :past_performances do |t|

      t.timestamps
    end
  end
end
