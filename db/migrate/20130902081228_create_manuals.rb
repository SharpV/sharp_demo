class CreateManuals < ActiveRecord::Migration
  def change
    create_table :manuals do |t|
      t.integer :product_id
      t.string :file
      t.timestamps
    end
    add_index :manuals, :product_id
  end
end
