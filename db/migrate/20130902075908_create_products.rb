class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.timestamps
    end

    add_index :products, :category_id

    rename_column :categories, :user_id, :parent_id
    add_column :categories, :lft, :integer
    add_column :categories, :rgt, :integer
    add_column :categories, :depth, :integer
    rename_column :categories, :posts_count, :children_count
  end
end
