class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.datetime :date
      t.text :text
      t.boolean :current

      t.timestamps
    end
  end
end
