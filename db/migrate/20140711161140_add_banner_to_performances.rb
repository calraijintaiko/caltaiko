class AddBannerToPerformances < ActiveRecord::Migration
  def self.up
    add_attachment :performances, :banner
  end

  def self.down
    remove_attachment :performances, :banner
  end
end
