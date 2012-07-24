class AddPostAssets < ActiveRecord::Migration
  def up
    create_table "post_assets", :force => true do |t|
      t.integer :user_id
      t.integer :post_id
      t.datetime :created_at
      t.string  :file
    end
    
    add_index :post_assets, :user_id
    add_index :post_assets, :post_id
    add_column :documents, :file, :string
  end

  def down
  end
end
