class CreateImages < ActiveRecord::Migration
  def change
    remove_column :media, :image
    remove_column :media, :collections_count
    remove_column :media, :folder_id

    create_table :images do |t|
      t.integer  "creator_id"
      t.string   "file_name"
      t.integer  "file_size"
      t.string   "content_type"
      t.string   "file"
      t.boolean  "is_public",    :default => true
      t.integer  "imageable_id"
      t.string   "imageable_type"
      t.integer  "likes_count",       :default => 0
      t.integer  "comments_count", :default => 0
      t.integer  "readings_count",    :default => 0
      t.timestamps
    end
  end
end
