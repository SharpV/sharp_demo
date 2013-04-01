class AddCategoryIdToGroupTopics < ActiveRecord::Migration
  def change
    add_column :media, :comments_count, :integer, default: 0
    add_column :media, :mediumable_id, :integer
    add_column :media, :mediumable_type, :string
    add_column :media, :likes_count, :integer, default: 0
    add_column :media, :collections_count, :integer, default: 0
    add_column :media, :readings_count, :integer, default: 0

    add_column :groups, :posts_count, :integer, default: 0
    add_column :groups, :media_count, :integer, default: 0

    add_column :categories, :posts_count, :integer, default: 0
    add_column :folders, :media_count, :integer, default: 0

    rename_column :media, :user_id, :creator_id

    add_index :media, [:mediumable_type, :mediumable_id]
    add_index :posts, [:postable_type, :postable_id]
  end
end
