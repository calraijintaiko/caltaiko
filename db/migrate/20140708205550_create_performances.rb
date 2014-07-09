class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.datetime :date
      t.string :title
      t.string :location
      t.text :description
      t.boolean :upcoming

      t.timestamps
    end
  end
end
