class AddGenAndMajorToMembers < ActiveRecord::Migration
  def change
    add_column :members, :gen, :smallint
    add_column :members, :major, :string
  end
end
