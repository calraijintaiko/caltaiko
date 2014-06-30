class AddAvatarToMembers < ActiveRecord::Migration
  def self.up
    add_attachment :members, :avatar
  end

  def self.down
    remove_attachment :members, :avatar
  end
end
