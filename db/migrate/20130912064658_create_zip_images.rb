class CreateZipImages < ActiveRecord::Migration
  def change
    create_table :zip_images do |t|
      t.string :zipcode
      t.string :image_url
      t.attachment :image
      t.timestamps
    end
    add_index :zip_images, :zipcode
  end
end
