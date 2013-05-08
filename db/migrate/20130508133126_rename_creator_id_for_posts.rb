class RenameCreatorIdForPosts < ActiveRecord::Migration
  def up
    rename_column :posts, :creator_id, :user_id
    add_index :posts, :user_id
  end

  def down
  end
end
