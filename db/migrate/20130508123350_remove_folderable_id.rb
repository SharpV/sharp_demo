class RemoveFolderableId < ActiveRecord::Migration
  def up
    remove_column :folders, :folderable_type
    rename_column :folders, :folderable_id, :user_id
    rename_column :media, :creator_id, :user_id
    rename_column :categories, :creator_id, :user_id
    add_index :folders, :user_id
    add_index :categories, :user_id
    add_index :media, :user_id
    remove_column :categories, :categoryable_type
    remove_column :categories, :categoryable_id
  end

  def down
  end
end
