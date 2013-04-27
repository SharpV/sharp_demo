class AddAvatarToAlbum < ActiveRecord::Migration
  def change
    rename_column :albums, :media_count, :images_count
    add_column :albums, :image_id, :integer
  end
end
