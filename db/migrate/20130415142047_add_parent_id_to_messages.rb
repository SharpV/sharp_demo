class AddParentIdToMessages < ActiveRecord::Migration
  def change
    remove_column :posts, :published
    remove_column :posts, :file
    add_column :posts, :is_delete, :boolean, default: false
    add_column :messages, :parent_id, :integer
    add_index :messages, :parent_id
  end
end
