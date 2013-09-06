class CreateCrawlerMeta < ActiveRecord::Migration
  def change
    create_table :crawler_meta do |t|
      t.string :url
      t.integer :status 
      t.timestamps
    end
    add_index :crawler_meta, :url
    add_index :crawler_meta, :status

    rename_table :manuals, :product_manuals
  end
end
