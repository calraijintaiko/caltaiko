class AddSlugToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :slug, :string
    add_index :performances, :slug, unique: true
  end
end
