class AddImagesLinkToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :images_link, :string
  end
end
