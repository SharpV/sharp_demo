class ChangeFileToUrlForManuals < ActiveRecord::Migration
  def up
    rename_column :product_images, :file, :image_url
    rename_column :product_manuals, :cover, :cover_url
    rename_column :product_manuals, :file, :file_url
  end

  def down
  end
end
