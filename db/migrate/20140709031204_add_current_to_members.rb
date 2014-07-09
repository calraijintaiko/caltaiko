class AddCurrentToMembers < ActiveRecord::Migration
  def change
    add_column :members, :current, :boolean
  end
end
