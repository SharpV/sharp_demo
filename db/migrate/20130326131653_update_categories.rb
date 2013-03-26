class UpdateCategories < ActiveRecord::Migration
  def up
    create_table "categories", :force => true do |t|
      t.string  "name"
      t.string "categoryable_type"
      t.integer "categoryable_id"
      t.integer "creator_id"
    end

    add_index :categories, [:categoryable_id, :categoryable_type]

    drop_table :course_categories
    drop_table :post_categories
    drop_table :group_categories

    rename_column :folders, :depth, :folderable_id
    rename_column :folders, :parent_id, :creator_id
    remove_column :folders, :lft
    remove_column :folders, :rgt
    add_column :folders, :folderable_type, :string

    add_index :folders, [:folderable_type, :folderable_id]
  end

  def down
  end
end
