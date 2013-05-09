class AddAlbumsCountToGroup < ActiveRecord::Migration
  def change
    rename_column :groups, :likes_count, :images_count
    add_column :groups, :albums_count, :integer, default: 0
  end
end
