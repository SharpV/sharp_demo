class UpdateCategories < ActiveRecord::Migration
  def up
    rename_column :categories, :creator_id, :parent_id
    rename_column :categories, :categoryable_id, :lft
    add_column :categories, :rgt, :integer
    remove_column :categories, :categoryable_type
    rename_column :categories, :posts_count, :depth
  end

  def down
  end
end
