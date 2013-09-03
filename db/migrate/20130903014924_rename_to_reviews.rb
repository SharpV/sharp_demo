class RenameToReviews < ActiveRecord::Migration
  def up
    rename_table :posts, :reviews
    rename_column :reviews, :group_id, :product_id
    add_index :reviews, :product_id
  end

  def down
  end
end
