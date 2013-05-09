class RenameAlbumable < ActiveRecord::Migration
  def up
    rename_column :albums, :creator_id, :user_id
    rename_column :albums, :albumable_id, :group_id
    remove_column :albums, :albumable_type

    rename_column :images, :creator_id, :group_id
    rename_column :images, :imageable_id, :user_id
    remove_column :images, :imageable_type

    add_index :albums, :user_id
    add_index :images, :user_id

    add_index :images, :group_id
    add_index :albums, :group_id

    add_column :users, :albums_count, :integer, default: 0
    add_column :users, :images_count, :integer, default: 0
  end

  def down
  end
end
