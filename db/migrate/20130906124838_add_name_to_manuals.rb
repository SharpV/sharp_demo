class AddNameToManuals < ActiveRecord::Migration
  def change
    add_column :product_manuals, :name, :string
  end
end
