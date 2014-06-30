class AddGenAndMajorToMembers < ActiveRecord::Migration
  def change
    add_column :members, :gen, :number
    add_column :members, :major, :string
  end
end
