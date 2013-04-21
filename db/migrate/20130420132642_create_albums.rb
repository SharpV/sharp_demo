class CreateAlbums < ActiveRecord::Migration
  def change
    remove_column :folders, :user_id
    add_column :folders, :created_at, :datetime

    create_table "albums", :force => true do |t|
      t.integer "creator_id"
      t.string  "name"
      t.integer "albumable_id"
      t.boolean "is_public",       :default => true
      t.string  "albumable_type"
      t.integer "media_count",     :default => 0
      t.datetime "created_at"
    end
    add_index :albums, :creator_id
    add_index :albums, [:albumable_type, :albumable_id]
  end
end
