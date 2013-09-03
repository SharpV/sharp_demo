class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :file
      t.integer :product_id
      t.timestamps
    end
    add_index :product_images, :product_id

    add_column :products, :recommended_items, :text
    add_column :products, :related_items, :text
    add_column :products, :coordinating_items, :text
    add_column :products, :price, :decimal, :precision => 8, :scale => 2
    add_column :products, :reviews_count, :integer, default: 0
  end
end
