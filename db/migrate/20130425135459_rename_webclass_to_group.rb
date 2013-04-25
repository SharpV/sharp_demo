class RenameWebclassToGroup < ActiveRecord::Migration
  def up
    drop_table :groups
    rename_table :webclasses, :groups
    add_column :groups, :is_class, :boolean, default: false
    remove_column :members, :memberable_type
    rename_column :members, :memberable_id, :group_id
    add_index :members, :group_id
    rename_column :groups, :collections_count, :posts_count
    rename_column :groups, :comments_count, :media_count
  end

  def down
  end
end
