class ResetSomeColumnsOfProducts < ActiveRecord::Migration
  def up
    remove_column :products, :recommended_items
    remove_column :products, :coordinating_items
    remove_column :products, :additional_info
    add_column :products, :recommended_items, :string, :null => true
    add_column :products, :coordinating_items, :string, :null => true
    add_column :products, :additional_info, :string, :null => true
    rename_column :products, :related_items, :additional_info
  end

  def down
  end
end
