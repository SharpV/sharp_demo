class AddCoverToManuals < ActiveRecord::Migration
  def change
    add_column :product_manuals, :cover, :string
  end
end
