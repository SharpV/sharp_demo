class CreateMedia < ActiveRecord::Migration
  def change
    create_table :medias do |t|
      t.integer  "user_id"
      t.integer  "folder_id"
      t.string   "file_name"
      t.integer  "file_size"
      t.string   "content_type"
      t.string   "file"
      t.string   "play_path"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end

    add_index :medias, :user_id
    add_index :medias, :folder_id

    create_table :folders do |t|
      t.integer  "user_id"
      t.integer "parent_id"
      t.string  "name"
      t.integer "lft"
      t.integer "rgt"
      t.integer "depth"
    end
    add_index :folders, :user_id

    rename_table :categories, :post_categories

    add_column :post_categories, :user_id, :integer
    remove_column :post_categories, :categoryable_id
    remove_column :post_categories, :categoryable_type

  end
end
