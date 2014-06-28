class AddNameAndBioToMembers < ActiveRecord::Migration
  def change
    add_column :members, :name, :string
    add_column :members, :bio, :text
  end
end
