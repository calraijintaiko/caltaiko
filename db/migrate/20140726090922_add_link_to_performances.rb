class AddLinkToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :link, :string
  end
end
