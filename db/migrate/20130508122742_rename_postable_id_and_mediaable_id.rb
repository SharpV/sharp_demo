class RenamePostableIdAndMediaableId < ActiveRecord::Migration
  def up
    rename_column :posts, :postable_id, :group_id
    add_index :posts, :group_id
    remove_column :posts, :postable_type

    rename_column :media, :mediumable_id, :group_id
    add_index :media, :group_id
    remove_column :media, :mediumable_type
    add_column :media, :folder_id, :integer
    add_index :media, :folder_id
  end

  def down
  end
end
