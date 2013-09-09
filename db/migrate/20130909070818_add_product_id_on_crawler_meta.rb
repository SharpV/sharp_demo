class AddProductIdOnCrawlerMeta < ActiveRecord::Migration
  def change
    add_column :crawler_meta, :product_id, :integer
  end
end
